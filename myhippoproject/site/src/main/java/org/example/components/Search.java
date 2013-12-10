package org.example.components;

import org.example.componentsinfo.SearchInfo;
import org.hippoecm.hst.core.parameters.ParametersInfo;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.core.component.HstComponentException;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@ParametersInfo(type = SearchInfo.class)
public class Search extends BaseComponent {

    public static final Logger log = LoggerFactory.getLogger(Search.class);

    @Override
    public void doBeforeRender(final HstRequest request, final HstResponse response) throws HstComponentException {

       SearchInfo info = getComponentParametersInfo(request);
       HippoBean scope = request.getRequestContext().getSiteContentBaseBean();

       String query = getPublicRequestParameter(request, "query");

       createAndExecuteSearch(request, info, scope, query);
    }

}
