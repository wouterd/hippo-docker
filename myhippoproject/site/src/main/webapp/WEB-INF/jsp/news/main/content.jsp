<%@ include file="/WEB-INF/jspf/htmlTags.jspf" %>
<%--@elvariable id="document" type="org.example.beans.NewsDocument"--%>

<c:choose>
  <c:when test="${empty document}">
    <tag:pagenotfound/>
  </c:when>
  <c:otherwise>
    <c:if test="${not empty document.title}">
      <hst:element var="headTitle" name="title">
        <c:out value="${document.title}"/>
      </hst:element>
      <hst:headContribution keyHint="headTitle" element="${headTitle}"/>
    </c:if>

    <article class="well well-large">
      <hst:cmseditlink hippobean="${document}"/>
      <header>
        <h2>${fn:escapeXml(document.title)}</h2>
        <c:if test="${hst:isReadable(document, 'date.time')}">
          <p class="badge badge-info">
              <fmt:formatDate value="${document.date.time}" type="both" dateStyle="medium" timeStyle="short"/>
          </p>
        </c:if>
        <p>${fn:escapeXml(document.summary)}</p>
      </header>
      <hst:html hippohtml="${document.html}"/>
      <c:if test="${hst:isReadable(document, 'image.original')}">
        <hst:link var="img" hippobean="${document.image.original}"/>
        <figure>
          <img src="${img}" title="${fn:escapeXml(document.image.fileName)}"
            alt="${fn:escapeXml(document.image.fileName)}"/>
          <figcaption>${fn:escapeXml(document.image.description)}</figcaption>
        </figure>
      </c:if>
    </article>

  </c:otherwise>
</c:choose>