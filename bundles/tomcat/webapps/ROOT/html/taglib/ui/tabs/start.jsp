<%--
/**
 * SPDX-FileCopyrightText: (c) 2000 Liferay, Inc. https://liferay.com
 * SPDX-License-Identifier: LGPL-2.1-or-later OR LicenseRef-Liferay-DXP-EULA-2.0.0-2023-06
 */
--%>

<%@ include file="/html/taglib/ui/tabs/init.jsp" %>

<%

// URL

LiferayPortletURL portletURL = (LiferayPortletURL)request.getAttribute("liferay-ui:tabs:portletURL");

String url = GetterUtil.getString((String)request.getAttribute("liferay-ui:tabs:url"));
String anchor = StringPool.BLANK;
String separator = StringPool.AMPERSAND;

if (url != null) {

	// Strip existing tab parameter and value from the URL

	int x = url.indexOf(param + "=");

	if (x != -1) {
		int y = url.lastIndexOf("&", x);

		if (y == -1) {
			y = url.lastIndexOf("?", x);
		}

		int z = url.indexOf("&", y + 1);

		if (z == -1) {
			z = url.length();
		}

		url = url.substring(0, y) + url.substring(z);
	}

	// Strip trailing &

	if (url.endsWith("&")) {
		url = url.substring(0, url.length() - 1);
	}

	// Strip anchor

	String[] urlArray = PortalUtil.stripURLAnchor(url, "&#");

	anchor = urlArray[1];

	url = urlArray[0];

	if (!url.contains(StringPool.QUESTION)) {
		separator = StringPool.QUESTION;
	}
}

// Back url

String backLabel = (String)request.getAttribute("liferay-ui:tabs:backLabel");

String backURL = (String)request.getAttribute("liferay-ui:tabs:backURL");

if (Validator.isNotNull(backURL) && !backURL.equals("javascript:history.go(-1);")) {
	backURL = HtmlUtil.escapeHREF(PortalUtil.escapeRedirect(backURL));
}

// CSS class

String cssClass = GetterUtil.getString((String)request.getAttribute("liferay-ui:tabs:cssClass"));

// Refresh

boolean refresh = GetterUtil.getBoolean((String)request.getAttribute("liferay-ui:tabs:refresh"));

// onClick

String onClick = GetterUtil.getString((String)request.getAttribute("liferay-ui:tabs:onClick"));

// Type

String type = GetterUtil.getString((String)request.getAttribute("liferay-ui:tabs:type"), "tabs");
%>

<c:if test="<%= names.length > 0 %>">

	<%
	String oldPortletURLValue = null;

	if ((portletURL != null) && (param != null)) {
		oldPortletURLValue = portletURL.getParameter(param);
	}
	%>

	<input name="<%= namespace %><%= param %>TabsScroll" type="hidden" />

	<c:choose>
		<c:when test='<%= type.equals("dropdown") %>'>

			<%
			String name = value;

			int pos = Arrays.binarySearch(values, value);

			if (pos != -1) {
				name = names[pos];
			}
			%>

			<nav class="navbar <%= cssClass %>">
				<div class="container-fluid">
					<ul class="nav navbar-nav">
						<c:if test="<%= names.length > 1 %>">
							<li class="active dropdown nav-item">
								<button aria-haspopup="true" class="dropdown-toggle nav-link" data-toggle="liferay-dropdown">
									<span class="navbar-text-truncate" id="<%= namespace + param %>dropdownTitle"><liferay-ui:message key="<%= HtmlUtil.escape(name) %>" /></span>

									<aui:icon image="caret-bottom" markupView="lexicon" />
								</button>

								<ul class="dropdown-menu">
						</c:if>
		</c:when>
		<c:otherwise>
			<ul class="lfr-nav mb-3 mb-lg-4 nav nav-<%= type %> <%= cssClass %>" data-tabs-namespace="<%= namespace + param %>" role="tablist">
		</c:otherwise>
	</c:choose>

	<%
	for (int i = 0; i < values.length; i++) {
		String curURL = StringPool.BLANK;

		if ((urls != null) && (i < urls.length)) {
			curURL = urls[i];
		}

		if (Validator.isNull(curURL)) {
			if (values.length == 1) {
				/*if (Validator.isNotNull(backURL)) {
					curURL = backURL;
				}*/
			}
			else {
				if (refresh) {
					if (portletURL != null) {
						portletURL.setParameter(param, values[i]);

						curURL = portletURL.toString();
					}
					else {
						if (values[i].equals("&raquo;")) {
							curURL = url + separator + namespace + param + "=" + values[0] + anchor;
						}
						else {
							curURL = url + separator + namespace + param + "=" + values[i] + anchor;
						}
					}
				}
				else {
					curURL = "javascript:";

					if (Validator.isNotNull(formName)) {
						curURL += "document." + namespace + formName + "." + namespace + param + ".value = '" + names[i] + "';";
					}

					curURL += "Liferay.Portal.Tabs.show('" + namespace + param + "', " + namesJS + ", '" + UnicodeFormatter.toString(names[i]) + "');";
				}
			}
		}

		String curOnClick = StringPool.BLANK;

		if (Validator.isNotNull(onClick)) {
			if (refresh) {
				curOnClick = onClick + "('" + curURL + "', '" + values[i] + "'); return false;";
			}
			else {
				curOnClick = "Liferay.Portal.Tabs.show('" + namespace + param + "', " + namesJS + ", '" + UnicodeFormatter.toString(names[i]) + "', " + onClick + ");";
				curURL = "javascript:void(0);";
			}
		}

		boolean selected = (values.length == 1) || value.equals(values[i]);

		String linkCssClass = "nav-link";

		if (selected) {
			linkCssClass += " active";
		}
	%>

		<li class="nav-item" data-tab-name="<%= names[i] %>" id="<%= namespace %><%= param %><%= StringUtil.toCharCode(values[i]) %>TabsId" role="none">
			<a class="<%= linkCssClass %>" href="<%= Validator.isNotNull(curURL) ? HtmlUtil.escapeAttribute(curURL) : "javascript:void(0);" %>" onClick="<%= Validator.isNotNull(curOnClick) ? curOnClick : StringPool.BLANK %>" role="tab">
				<liferay-ui:message key="<%= HtmlUtil.escape(names[i]) %>" />
			</a>
		</li>

	<%
	}
	%>

	<c:if test="<%= Validator.isNotNull(backURL) %>">
		<li>
			<a class="tab" href="<%= backURL %>" id="<%= namespace %><%= param %>TabsBack"><%= Validator.isNotNull(backLabel) ? HtmlUtil.escape(backLabel) : "&laquo;" + LanguageUtil.get(resourceBundle, "back") %></a>
		</li>
	</c:if>

	<c:choose>
		<c:when test='<%= type.equals("dropdown") %>'>
						<c:if test="<%= names.length == 1 %>">
								</ul>
							</li>
						</c:if>
					</ul>
				</div>
			</nav>
		</c:when>
		<c:otherwise>
			</ul>
		</c:otherwise>
	</c:choose>

	<%
	if ((portletURL != null) && (param != null) && (oldPortletURLValue != null)) {
		portletURL.setParameter(param, oldPortletURLValue);
	}
	%>

</c:if>