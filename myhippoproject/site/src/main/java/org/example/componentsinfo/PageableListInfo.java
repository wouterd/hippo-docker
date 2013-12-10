package org.example.componentsinfo;

import org.hippoecm.hst.core.parameters.FieldGroup;
import org.hippoecm.hst.core.parameters.FieldGroupList;
import org.hippoecm.hst.core.parameters.Parameter;

@FieldGroupList({
        @FieldGroup(
                titleKey = "group.content",
                value = {"pagesVisible"}
        )
})
public interface PageableListInfo extends GeneralListInfo {

    @Parameter(name = "pagesVisible", defaultValue="true", displayName = "Show pages")
    Boolean isPagesVisible();

}
