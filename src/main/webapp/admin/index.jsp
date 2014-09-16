<%-- 
    Document   : index
    Created on : Sep 10, 2014, 12:56:21 PM
    Author     : philippe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ng-app="FeedReader">
    <head>
        <title>Edition des flux rss/atom</title>
        <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/webjars/bootstrap/3.2.0/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/feed.css"/>
        <script type="text/javascript" src="<%= request.getContextPath() %>/webjars/jquery/2.1.1/jquery.min.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/webjars/angularjs/1.2.19/angular.min.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/webjars/angularjs/1.2.19/angular-sanitize.min.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/js/feed.js"></script>
        <script>
            var webservicesUrl = {
                "feed": "/feedreader/ws/feed",
                "feedItem": "/feedreader/ws/feedItem",
            }
        </script>
    </head>
    <body>
        <div id="feed-edit" ng-controller="FeedController">
            <div ng-if="error != null" class="alert alert-danger">
                {{error}}
            </div>
            <button type="button" class="btn btn-primary" ng-click="addForm()">Ajouter un flux rss/atom</button>
            <div>
                <div ng-if="!feedLoading">Chargment de la liste des flux rss/atom</div>
                <div ng-repeat="feed in feeds">
                    <form class="form-inline">
                        <div class="form-group">
                            <input type="text" readonly="readonly" name="name" class="form-control" placeholder="Nom" value="{{feed.id}}" ng-model="feed.id"/>
                        </div>
                        <div class="form-group">
                            <input type="text" name="name" placeholder="Nom" class="form-control" value="{{feed.name}}" ng-model="feed.name"/>
                        </div>
                        <div class="form-group">
                            <!--  TODO tester le type url -->
                            <input type="text" name="name" placeholder="Url" class="form-control" value="{{feed.url}}" ng-model="feed.url"/>
                        </div>
                        <div class="form-group">
                            <textarea type="text" name="name" class="form-control" placeholder="Description" ng-model="feed.description">{{feed.description}}</textarea>
                        </div>
                        <div class="form-group">
                            <button type="button" class="btn btn-primary" ng-click="saveFeed(feed, $index)">
                                <span ng-disable="feed.sync" ng-if="feed.id == -1">Ajouter</span>
                                <span ng-disable="feed.sync" ng-if="feed.id > -1">Sauvegarder</span>
                            </button>
                            <button ng-if="feed.id > -1" type="button" class="btn btn-primary" ng-click="removeFeed(feed, $index)">
                                <span>Supprimer</span>
                            </button>
                            <img ng-if="feed.sync" src=""<%= request.getContextPath() %>/images/loader-line.gif" />
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
