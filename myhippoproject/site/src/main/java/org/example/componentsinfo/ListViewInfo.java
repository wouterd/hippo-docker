package org.example.componentsinfo;

import org.hippoecm.hst.configuration.hosting.Mount;
import org.hippoecm.hst.core.parameters.Color;
import org.hippoecm.hst.core.parameters.FieldGroup;
import org.hippoecm.hst.core.parameters.FieldGroupList;
import org.hippoecm.hst.core.parameters.Parameter;

@FieldGroupList({
        @FieldGroup(
                titleKey = "group.content",
                value = {"scope"}
        ),
        @FieldGroup(
                titleKey = "group.sorting",
                value = {}
        ),
        @FieldGroup(
                titleKey = "group.layout",
                value = {"cssClass", "bgColor"}
        )
})
public interface ListViewInfo extends GeneralListInfo {

    /**
     * Returns the scope to search below. Leading and trailing slashes do not have meaning and will be skipped when using the scope. The scope
     * is always relative to the current {@link Mount#getContentPath()}, even if it starts with a <code>/</code>
     * @return the scope to search below
     */
    @Parameter(name = "scope", defaultValue="/")
    String getScope();

    @Override
    @Parameter(name = "title", defaultValue="List")
    String getTitle();
    
    @Parameter(name = "cssClass", defaultValue="lightgrey")
    String getCssClass();

    @Parameter(name = "bgColor", defaultValue="")
    @Color
    String getBgColor();

}
