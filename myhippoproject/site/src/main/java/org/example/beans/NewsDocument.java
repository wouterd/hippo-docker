package org.example.beans;

import java.util.Calendar;

import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoHtml;
import org.hippoecm.hst.content.beans.standard.HippoGalleryImageSetBean;

@Node(jcrType="myhippoproject:newsdocument")
public class NewsDocument extends BaseDocument{

    public String getTitle() {
        return getProperty("myhippoproject:title");
    }
    
    public String getSummary() {
        return getProperty("myhippoproject:summary");
    }
    
    public Calendar getDate() {
        return getProperty("myhippoproject:date");
    }

    public HippoHtml getHtml(){
        return getHippoHtml("myhippoproject:body");    
    }

    /**
     * Get the imageset of the newspage
     *
     * @return the imageset of the newspage
     */
    public HippoGalleryImageSetBean getImage() {
        return getLinkedBean("myhippoproject:image", HippoGalleryImageSetBean.class);
    }


}
