<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<hst:element var="headTitle" name="title">
   <fmt:message key="page.not.found"/>
 </hst:element>
<hst:headContribution keyHint="headTitle" element="${headTitle}"/>
<h2><fmt:message key="page.not.found"/></h2>