package org.example.components;

import java.util.Collections;
import org.hippoecm.hst.configuration.hosting.Mount;
import org.hippoecm.hst.container.ModifiableRequestContextProvider;
import org.hippoecm.hst.content.beans.manager.ObjectConverter;
import org.hippoecm.hst.content.beans.manager.ObjectConverterImpl;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.content.tool.ContentBeansTool;
import org.hippoecm.hst.content.tool.DefaultContentBeansTool;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.request.ComponentConfiguration;
import org.hippoecm.hst.core.request.HstRequestContext;
import org.hippoecm.hst.core.request.ResolvedMount;
import org.hippoecm.hst.core.request.ResolvedSiteMapItem;
import org.hippoecm.hst.mock.content.beans.standard.MockHippoBean;
import org.hippoecm.hst.mock.core.component.MockHstRequest;
import org.hippoecm.hst.mock.core.request.MockComponentConfiguration;
import org.hippoecm.hst.mock.core.request.MockHstRequestContext;
import org.hippoecm.hst.mock.core.request.MockResolvedSiteMapItem;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static org.easymock.EasyMock.createMock;
import static org.easymock.EasyMock.expect;
import static org.easymock.EasyMock.expectLastCall;
import static org.easymock.EasyMock.replay;
import static org.easymock.EasyMock.verify;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

/**
 * Test class for {@link Detail}
 */
public class DetailTest {

    private ContentBeansTool contentBeansTool;

    @Before
    public void setUp() throws Exception {
        contentBeansTool = new DefaultContentBeansTool(null) {
            @Override
            public ObjectConverter getObjectConverter() {
                return new ObjectConverterImpl(Collections.EMPTY_MAP, new String[0]);
            }
        };
    }

    @After
    public void tearDown() throws Exception {
        ModifiableRequestContextProvider.clear();
    }

    @Test
    public void doBeforeRender_FoundBean() throws Exception {
        HippoBean detailBean = new MockHippoBean();

        ComponentConfiguration componentConfiguration = new MockComponentConfiguration();
        HstRequest request = new MockHstRequest();
        HstResponse response = createMock(HstResponse.class);
        HstRequestContext requestContext = new MockHstRequestContext();
        ((MockHstRequestContext) requestContext).setContentBean(detailBean);
        ((MockHstRequestContext) requestContext).setContentBeansTool(contentBeansTool);

        ((MockHstRequest) request).setRequestContext(requestContext);
        ModifiableRequestContextProvider.set(requestContext);
        replay(response);

        Detail detail = new Detail();
        detail.init(null, componentConfiguration);
        detail.doBeforeRender(request, response);
        verify(response);

        assertEquals(detailBean, request.getAttribute("document"));
    }

    @Test
    public void doBeforeRender_MissingBean() throws Exception {

        ComponentConfiguration componentConfiguration = new MockComponentConfiguration();
        HstRequest request = new MockHstRequest();
        HstResponse response = createMock(HstResponse.class);

        HstRequestContext requestContext = new MockHstRequestContext();
        ResolvedMount resolvedMount = createMock(ResolvedMount.class);
        Mount mount = createMock(Mount.class);
        ((MockHstRequestContext) requestContext).setResolvedMount(resolvedMount);
        ((MockHstRequestContext) requestContext).setContentBeansTool(contentBeansTool);

        ResolvedSiteMapItem resolvedSiteMapItem = new MockResolvedSiteMapItem();
        ((MockResolvedSiteMapItem) resolvedSiteMapItem).setRelativeContentPath("common/detail");
        ((MockHstRequestContext) requestContext).setResolvedSiteMapItem(resolvedSiteMapItem);

        ((MockHstRequest) request).setRequestContext(requestContext);
        ModifiableRequestContextProvider.set(requestContext);

        expect(resolvedMount.getMount()).andReturn(mount);
        expect(mount.getContentPath()).andReturn("/hst:hst/hst:sites/mysite-live/hst:content");

        ((MockHstRequest) request).setRequestContext(requestContext);

        response.setStatus(HstResponse.SC_NOT_FOUND);
        expectLastCall();
        replay(response);

        Detail detail = new Detail();
        detail.init(null, componentConfiguration);
        detail.doBeforeRender(request, response);
        verify(response);

        assertNull(request.getAttribute("document"));
    }

}
