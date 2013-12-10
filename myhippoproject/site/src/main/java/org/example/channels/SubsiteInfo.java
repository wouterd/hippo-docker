package org.example.channels;

import org.hippoecm.hst.configuration.channel.ChannelInfo;
import org.hippoecm.hst.core.parameters.FieldGroup;
import org.hippoecm.hst.core.parameters.FieldGroupList;
import org.hippoecm.hst.core.parameters.Parameter;

/**
 * Retrieves the properties of a subsite channel.
 */
@FieldGroupList({
        @FieldGroup(
                titleKey = "fields.subsite",
                value = { "headerName" }
        )
})
public interface SubsiteInfo extends ChannelInfo {

    @Parameter(name = "headerName", defaultValue = "HST Subsite")
    String getHeaderName();

}
