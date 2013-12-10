package org.example.componentsinfo;

import org.hippoecm.hst.core.parameters.FieldGroup;
import org.hippoecm.hst.core.parameters.FieldGroupList;
import org.hippoecm.hst.core.parameters.Parameter;

@FieldGroupList({
        @FieldGroup(
                titleKey = "group.content",
                value = {"title", "pageSize", "docType"}
        ),
        @FieldGroup(
                titleKey = "group.sorting",
                value = {"sortBy", "sortOrder"}
        )
})
public interface GeneralListInfo  {

    @Parameter(name = "title", displayName = "The title of the page", defaultValue="Overview")
    String getTitle();

    @Parameter(name = "pageSize", displayName = "Page Size", defaultValue="10")
    int getPageSize();

    @Parameter(name = "docType", displayName = "Document Type", defaultValue="myhippoproject:basedocument")
    String getDocType();

    @Parameter(name = "sortBy", displayName = "Sort By Property")
    String getSortBy();

    @Parameter(name = "sortOrder", displayName = "Sort Order", defaultValue="descending")
    String getSortOrder();

}
