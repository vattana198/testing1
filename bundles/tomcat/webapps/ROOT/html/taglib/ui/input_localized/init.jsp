<%--
/**
 * SPDX-FileCopyrightText: (c) 2000 Liferay, Inc. https://liferay.com
 * SPDX-License-Identifier: LGPL-2.1-or-later OR LicenseRef-Liferay-DXP-EULA-2.0.0-2023-06
 */
--%>

<%@ include file="/html/taglib/init.jsp" %>

<%@ page import="com.liferay.portal.kernel.editor.Editor" %><%@
page import="com.liferay.taglib.ui.InputEditorTag" %>

<%
String randomNamespace = PortalUtil.generateRandomKey(request, "taglib_ui_input_localized") + StringPool.UNDERLINE;

List<String> activeLanguageIds = (List<String>)request.getAttribute("liferay-ui:input-localized:activeLanguageIds");
boolean adminMode = GetterUtil.getBoolean((String)request.getAttribute("liferay-ui:input-localized:adminMode"));
boolean autoFocus = GetterUtil.getBoolean((String)request.getAttribute("liferay-ui:input-localized:autoFocus"));
boolean autoSize = GetterUtil.getBoolean((String)request.getAttribute("liferay-ui:input-localized:autoSize"));
Set<Locale> availableLocales = (Set<Locale>)request.getAttribute("liferay-ui:input-localized:availableLocales");
String cssClass = GetterUtil.getString((String)request.getAttribute("liferay-ui:input-localized:cssClass"));
String defaultLanguageId = (String)request.getAttribute("liferay-ui:input-localized:defaultLanguageId");
boolean disabled = GetterUtil.getBoolean((String)request.getAttribute("liferay-ui:input-localized:disabled"));
Map<String, Object> dynamicAttributes = (Map<String, Object>)request.getAttribute("liferay-ui:input-localized:dynamicAttributes");
String editorName = GetterUtil.getString((String)request.getAttribute("liferay-ui:input-localized:editorName"));
String fieldPrefix = GetterUtil.getString((String)request.getAttribute("liferay-ui:input-localized:fieldPrefix"));
String fieldPrefixSeparator = GetterUtil.getString((String)request.getAttribute("liferay-ui:input-localized:fieldPrefixSeparator"));
String helpMessage = GetterUtil.getString((String)request.getAttribute("liferay-ui:input-localized:helpMessage"));
String id = HtmlUtil.getAUICompatibleId((String)request.getAttribute("liferay-ui:input-localized:id"));
boolean ignoreRequestValue = GetterUtil.getBoolean((String)request.getAttribute("liferay-ui:input-localized:ignoreRequestValue"));
String inputAddon = (String)request.getAttribute("liferay-ui:input-localized:inputAddon");
String languageId = (String)request.getAttribute("liferay-ui:input-localized:languageId");
String languagesDropdownDirection = GetterUtil.getString((String)request.getAttribute("liferay-ui:input-localized:languagesDropdownDirection"));
boolean languagesDropdownVisible = GetterUtil.getBoolean((String)request.getAttribute("liferay-ui:input-localized:languagesDropdownVisible"));
String maxLength = GetterUtil.getString((String)request.getAttribute("liferay-ui:input-localized:maxLength"));
String name = (String)request.getAttribute("liferay-ui:input-localized:name");
String placeholder = (String)request.getAttribute("liferay-ui:input-localized:placeholder");
String selectedLanguageId = GetterUtil.getString((String)request.getAttribute("liferay-ui:input-localized:selectedLanguageId"));
String toolbarSet = (String)request.getAttribute("liferay-ui:input-localized:toolbarSet");
String type = (String)request.getAttribute("liferay-ui:input-localized:type");
String xml = (String)request.getAttribute("liferay-ui:input-localized:xml");

Locale defaultLocale = null;

if (Validator.isNotNull(defaultLanguageId)) {
	defaultLocale = LocaleUtil.fromLanguageId(defaultLanguageId);
}
else {
	defaultLocale = LocaleUtil.getSiteDefault();

	defaultLanguageId = LocaleUtil.toLanguageId(defaultLocale);
}

if (Validator.isNull(selectedLanguageId)) {
	selectedLanguageId = defaultLanguageId;
}

String mainLanguageId = selectedLanguageId;

if (Validator.isNotNull(languageId)) {
	mainLanguageId = languageId;
}

Locale mainLocale = LocaleUtil.fromLanguageId(mainLanguageId);

String mainLanguageDir = LanguageUtil.get(mainLocale, "lang.dir");

String mainLanguageValue = LocalizationUtil.getLocalization(xml, mainLanguageId, false);

if (!ignoreRequestValue) {
	mainLanguageValue = ParamUtil.getString(request, name + StringPool.UNDERLINE + mainLanguageId, mainLanguageValue);
}

String fieldNamePrefix = StringPool.BLANK;
String fieldNameSuffix = StringPool.BLANK;

if (Validator.isNotNull(fieldPrefix)) {
	fieldNamePrefix = fieldPrefix + fieldPrefixSeparator;
	fieldNameSuffix = fieldPrefixSeparator;
}

String fieldSuffix = StringPool.BLANK;

if (Validator.isNotNull(languageId)) {
	fieldSuffix = StringPool.UNDERLINE + mainLanguageId;
}

List<String> languageIds = new ArrayList<String>();

String fieldName = HtmlUtil.getAUICompatibleId(name) + fieldSuffix;

String inputEditorName = fieldName + "Editor";

Exception exception = (Exception)request.getAttribute("liferay-ui:error:exception");
String focusField = (String)request.getAttribute("liferay-ui:error:focusField");

Set<Locale> errorLocales = new HashSet<Locale>();

if ((exception != null) && fieldName.equals(focusField) && (exception instanceof LocalizedException)) {
	LocalizedException le = (LocalizedException)exception;

	Map<Locale, Exception> localizedExceptionsMap = le.getLocalizedExceptionsMap();

	errorLocales = localizedExceptionsMap.keySet();
}
%>