package org.example.componentsinfo;

import org.hippoecm.hst.core.parameters.Parameter;

public interface SearchInfo extends PageableListInfo {
    
    @Override
    @Parameter(name = "title", displayName = "The title of the page", defaultValue="Search Result")
    String getTitle();
    
}
