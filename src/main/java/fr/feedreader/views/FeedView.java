/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fr.feedreader.views;

import com.vaadin.cdi.CDIView;
import com.vaadin.navigator.View;
import com.vaadin.navigator.ViewChangeListener;
import com.vaadin.server.FontAwesome;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.Label;
import com.vaadin.ui.MenuBar;
import com.vaadin.ui.VerticalLayout;
import com.vaadin.ui.themes.ValoTheme;
import fr.feedreader.buisness.FeedBuisness;
import fr.feedreader.models.Feed;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;

/**
 *
 * @author glopinous
 */
@CDIView
public class FeedView extends VerticalLayout implements View {

    private boolean init = false;
    
    private List<Button> feedButtons = new ArrayList<>();
    
    @Inject
    private FeedBuisness feedBuisness;
    
    @Override
    public void enter(ViewChangeListener.ViewChangeEvent event) {
        System.out.println("init = " + init);
        if(init) {
            
        } else {
            removeAllComponents();
            addStyleName("feed");
            Map<Feed, Long> countUnread = feedBuisness.countUnread();
            HorizontalLayout titleLayout = new HorizontalLayout();
            Label title = new Label("Visualisation des flux rss/atom");
            title.setWidthUndefined();
            titleLayout.addComponent(title);
            titleLayout.setComponentAlignment(title, Alignment.MIDDLE_CENTER);
            titleLayout.setStyleName("title");
            titleLayout.setWidth("100%");
            titleLayout.setSpacing(true);
            addComponent(titleLayout);
            feedBuisness.findAll().stream().forEach((feed) -> {
                Long countUnreadFeed = countUnread.get(feed);
                Button b = new Button(feed.getName() + (countUnreadFeed != null ? " <span class=\"badge\">" + countUnreadFeed + "</span>" : ""));
                b.setHtmlContentAllowed(true);
                b.setIcon(FontAwesome.ARROW_CIRCLE_RIGHT);
                b.addStyleName(ValoTheme.BUTTON_ICON_ALIGN_RIGHT);
                b.addStyleName("multiline");
                if (countUnreadFeed != null && countUnreadFeed > 0) {
                    b.addStyleName(ValoTheme.BUTTON_FRIENDLY);
                }
                b.addClickListener((clickEvent) -> {
                    getUI().getNavigator().navigateTo("feedItem/" + feed.getId() + "/1");
                });
                b.setWidth(100, Unit.PERCENTAGE);
                addComponent(b);
            });
        }
    }
    
}