<%@page contentType="text/html" pageEncoding="UTF-8"%><!DOCTYPE html>
<html ng-app="FeedReader">
    <head>
        <title>Visualisation des flux rss/atom</title>
        <jsp:include page="/WEB-INF/head.jsp"/>
    </head>
    <body>
        <div id="feed" class="row" ng-controller="FeedController">
            <div id="feed-list">
                <div class="loader" ng-if="!feedLoading">
                    <jsp:include page="/WEB-INF/loader.jsp"/>
                </div>
                <ul>
                    <li ng-if="feedLoading" ng-repeat="feed in feeds" class="feed">
                        <button title="{{feed.lastUpdate}}" ng-class="{'btn-success': feed.selected, 'btn-default': !feed.selected}" type="button" class="btn" ng-click="loadFeedItem(feed)" >{{feed.name}}<span ng-if="feed.unread > 0" class="badge">{{feed.unread}}</span></button>
                    </li>
                </ul>
            </div>
            <div id="feed-list-toggle"></div>
            <div id="feed-items-container">
                <div class="loader" ng-if="feedItemsLoading">
                    <jsp:include page="/WEB-INF/loader.jsp"/>
                </div>
                <div ng-if="currentFeed != null" style="text-align: center">
                    <h2>{{currentFeed.name}}</h2>
                    <small>{{currentFeed.lastUpdate}}</small>
                </div>
                <div id="feed-one-paginator">
                    <button ng-class="{'btn-success': page.selected, 'btn-primary': !page.selected}" class="btn page" ng-repeat="page in feedItemPages" ng-click="loadFeedItem(feed, page.id)">{{page.label}}</button>
                </div>
                <div id="feed-one" class="panel-group">
                    <div class="panel panel-default" ng-repeat="feedItem in feedItems" data-readed="{{feedItem.url.toRead}}">
                        <div class="panel-heading">
                            <h4 class="panel-title" ng-class="{'bg-info': !feedItem.readed}" ng-click="loadSummary(feedItem)">
                                <span class="readed" ng-click="setReaded(feedItem.url.reverseReaded, $index)">
                                    <span ng-if="feedItem.readed" class="glyphicon glyphicon-star"></span>
                                    <span ng-if="!feedItem.readed" class="glyphicon glyphicon-star-empty"></span>
                                </span>
                                <a class="glyphicon glyphicon-eye-open " href="{{feedItem.link}}"></a>
                                <img height="30" ng-if="feedItem.enclosure" alt="icon" ng-src="{{feedItem.enclosure}}" />
                                <a data-toggle="collapse" href="#feedItem-{{feedItem.id}}">
                                    {{feedItem.title}} <small>{{feedItem.updated | feedItemData}}</small>
                                </a>
                            </h4>
                        </div>
                        <div id="feedItem-{{feedItem.id}}" class="panel-collapse collapse">
                            <ul class="nav nav-tabs">
                                <li class="active"><a class="tab-resume" href="#feedItem-{{feedItem.id}}-resume">Résumé</a></li>
                                <li><a class="tab-link" href="#feedItem-{{feedItem.id}}-link">Article</a></li>
                            </ul>
                            <p ng-if="feedItem.summary" class="feeditem-resume" id="feedItem-{{feedItem.id}}-resume" ng-bind-html="feedItem.summary">
                            <p>
                            <p ng-if="!feedItem.summary" class="resume" id="feedItem-{{feedItem.id}}-resume">
                                --- Pas de résumé ---
                            <p>
                            <p class="link" id="feedItem-{{feedItem.id}}-link" data-href="{{feedItem.link}}">
                            </p>
                        </div>
                    </div>
                </div>
            </div>
    </body>
</html>
