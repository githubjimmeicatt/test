

'
' DotNetNuke® - http://www.dotnetnuke.com
' Copyright (c) 2002-2006
' by Perpetual Motion Interactive Systems Inc. ( http://www.perpetualmotion.ca )
'
' Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
' documentation files (the "Software"), to deal in the Software without restriction, including without limitation 
' the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and 
' to permit persons to whom the Software is furnished to do so, subject to the following conditions:
'
' The above copyright notice and this permission notice shall be included in all copies or substantial portions 
' of the Software.
'
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED 
' TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
' THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
' CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
' DEALINGS IN THE SOFTWARE.
'
Imports DotNetNuke
Imports DotNetNuke.Security.Membership
Imports DotNetNuke.Security.Roles
Imports System.Web.UI
Imports System.Collections.Generic
Imports System.Collections.Specialized
Imports System.Reflection
Imports DotNetNuke.Entities.Modules

Imports ModuleSettingNames = Icatt.DotNetNuke.Modules.GoogleSearchResults.GoogleSearchResultsController.ModuleSettingNames

Namespace Icatt.DotNetNuke.Modules.GoogleSearchResults

    ''' -----------------------------------------------------------------------------
    ''' <summary>
    ''' The ViewDynamicModule class displays the content
    ''' </summary>
    ''' <remarks>
    ''' </remarks>
    ''' <history>
    ''' </history>
    ''' -----------------------------------------------------------------------------
    Partial Class ViewGoogleSearchResults
        Inherits PortalModuleBase
        Implements IActionable

#Region "Private Members"


        Public Const DefaultPageSize As Int32 = 25

        'Settings
        Private pageSize As Int32 = DefaultPageSize

        Private defaultCollectionField As String = Nothing
        Private defaultFrontEndField As String = Nothing
        Private roleBasedCollectionSettingField As String = Nothing
        Private roleBasedCollectonField As Generic.Dictionary(Of String, Generic.List(Of String)) = Nothing
        Private searchCollectionField As String = Nothing

        'Private Shared xslTransformerField As System.Xml.Xsl.XslCompiledTransform = Nothing
        'Private Shared ReadOnly xslTransformerLock As New Object


        Private queryField As String = Nothing

        Private ReadOnly Property defaultCollection() As String
            Get
                If defaultCollectionField Is Nothing Then
                    If CType(Settings(ModuleSettingNames.DefaultCollection), String) <> "" Then
                        Me.defaultCollectionField = Settings(ModuleSettingNames.DefaultCollection).ToString
                    Else
                        defaultCollectionField = String.Empty
                    End If

                End If
                Return defaultCollectionField

            End Get
        End Property
        Private ReadOnly Property roleBasedCollectionSetting() As String
            Get
                If roleBasedCollectionSettingField Is Nothing Then
                    If CType(Settings(ModuleSettingNames.RoleCollections), String) <> "" Then
                        Me.roleBasedCollectionSettingField = Settings(ModuleSettingNames.RoleCollections)
                    Else
                        roleBasedCollectionSettingField = String.Empty
                    End If

                End If
                Return roleBasedCollectionSettingField

            End Get
        End Property

        Private ReadOnly Property roleBasedCollections() As Generic.Dictionary(Of String, Generic.List(Of String))
            Get
                If Me.roleBasedCollectonField Is Nothing Then
                    Me.roleBasedCollectonField = New Generic.Dictionary(Of String, Generic.List(Of String))

                    Dim setting As String = Me.roleBasedCollectionSetting

                    If Not String.IsNullOrEmpty(setting) Then
                        Dim roles As String() = setting.Split(";")
                        For Each roleSetting As String In roles
                            Dim rolecollList As String() = roleSetting.Split(",")
                            Dim collList As New Generic.List(Of String)

                            Me.roleBasedCollectonField(rolecollList(0)) = collList

                            For i As Int32 = 1 To rolecollList.Length - 1
                                collList.Add(rolecollList(i))
                            Next

                        Next

                    End If

                End If
                Return Me.roleBasedCollectonField
            End Get
        End Property
        Private ReadOnly Property searchCollection() As String
            Get
                If searchCollectionField Is Nothing Then
                    Dim list As New Generic.List(Of String)
                    Dim defaultList As New Generic.List(Of String)

                    'Add default collection
                    Dim defaultCollList As String() = Me.defaultCollectionField.Split(",")
                    For Each coll As String In defaultCollList
                        If Not defaultList.Contains(coll) Then defaultList.Add(coll)
                    Next

                    'Add user based roles if any
                    If Me.roleBasedCollectionSetting.Length > 0 Then

                        'Get the roles of the current user
                        'Dim roles As System.Collections.ArrayList = Global.DotNetNuke.Security.Permissions.PermissionController.GetPermissionsByTab()

                        Dim roles As ArrayList = DNNRoleProvider.Instance.GetUserRoles( _
                                            PortalSettings.PortalId, _
                                            Global.DotNetNuke.Entities.Users.UserController.GetCurrentUserInfo().UserID, _
                                            True)

                        For Each role As RoleInfo In roles
                            processSearchCollection(role.RoleName, list, defaultList)
                        Next

                        If Page.User.Identity.IsAuthenticated Then
                            processSearchCollection("Authenticated", list, defaultList)
                        Else
                            processSearchCollection("UnAuthenticated", list, defaultList)
                        End If

                    End If

                    'Merge default list and rolebBased list
                    Dim out As New StringBuilder
                    For Each role As String In defaultList
                        If out.Length > 0 Then
                            out.Append("|")
                        End If
                        out.Append(role)
                    Next
                    For Each role As String In list
                        If out.Length > 0 Then
                            out.Append("|")
                        End If
                        out.Append(role)
                    Next

                    searchCollectionField = out.ToString
                End If

                Return searchCollectionField
            End Get
        End Property

        Private Sub processSearchCollection(ByVal roleName As String, ByVal list As Generic.List(Of String), ByVal defaultList As Generic.List(Of String))
            If Me.roleBasedCollections.ContainsKey(roleName) Then
                Dim collList As Generic.List(Of String) = roleBasedCollections(roleName)
                For Each coll As String In collList
                    If coll.StartsWith("-") Then
                        'remove role from default list
                        If defaultList.Contains(roleName) Then
                            defaultList.Remove(roleName)
                        End If
                    ElseIf Not list.Contains(coll) Then
                        list.Add(coll)
                    End If
                Next
            End If
        End Sub

        Private Property query() As String
            Get
                If queryField Is Nothing Then
                    'Get params from post ----------------------------------------

                    queryField = Request.Form(GoogleMiniParameterNames.Query)

                    'If empty, get params from querystring ----------------------------------------
                    If String.IsNullOrEmpty(queryField) Then
                        queryField = Request.QueryString(GoogleMiniParameterNames.Query)
                    End If

                End If

                Return Me.queryField

            End Get

            Set(ByVal value As String)
                queryField = value
            End Set
        End Property


        Private searchExecuted As Boolean = False

        ''' <summary>
        ''' Sigleton voor de XslTransformer 
        ''' </summary>
        ''' <value></value>
        ''' <returns></returns>
        ''' <remarks>Ondersteunt nu slechts één Xsl voor hele host. Moet naar lib die lijst met Xsl's in cache houdt.</remarks>
        Private Shared ReadOnly Property xslTransformer() As System.Xml.Xsl.XslCompiledTransform
            Get
                Return GoogleSearchResultsController.XslTransformer()

                'If xslTransformerField Is Nothing Then

                '	xslTransformerField = New System.Xml.Xsl.XslCompiledTransform(False)

                '	ViewGoogleSearchResults.loadXsl("~\DesktopModules\Icatt.GoogleSearchResults\SearchResults.xsl")

                'End If


                'Return xslTransformerField
            End Get


        End Property


#End Region

#Region "Event Handlers"

        Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init

            'Forces reload of xsl on every request. For debugging only...
#If DEBUG Then
	GoogleSearchResultsController.ReloadXsl()
#End If




        End Sub

        ''' -----------------------------------------------------------------------------
        ''' <summary>
        ''' Page_Load runs when the control is loaded
        ''' </summary>
        ''' <remarks>
        ''' </remarks>
        ''' <history>
        ''' </history>
        ''' -----------------------------------------------------------------------------
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
            Try


                'Get settings
                If CType(Settings(ModuleSettingNames.DefaultPageSize), String) <> "" Then
                    If Not Int32.TryParse(CType(Settings(ModuleSettingNames.DefaultPageSize), String), pageSize) Then
                        pageSize = DefaultPageSize
                    End If
                End If

                If CType(Settings(ModuleSettingNames.DefaultCollection), String) <> "" Then
                    Me.defaultCollectionField = Settings(ModuleSettingNames.DefaultCollection).ToString
                End If

                If CType(Settings(ModuleSettingNames.DefaultFrontEndName), String) <> "" Then
                    Me.defaultFrontEndField = Settings(ModuleSettingNames.DefaultFrontEndName).ToString
                End If

            Catch exc As Exception        'Module failed to load

                ProcessModuleLoadException(Me, exc)

            End Try


        End Sub


        'Protected Sub lbtSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtSubmit.Click

        '    Dim newQuery As String = Me.txtSearch.Text


        '    If Not String.IsNullOrEmpty(newQuery) Then

        '        Me.query = newQuery

        '        executeSearch(newQuery, True)

        '    Else
        '        'No querystring entered
        '        Me.ltrGoogleMiniSearchResults.Text = "No Query defined."

        '    End If


        'End Sub

        Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
            'Per form the search here and not on page load to avoid performing a search twice (first onload and second onclick) when the searchbutton in clicked...


            If Not String.IsNullOrEmpty(Me.query) Then

                If Not Me.searchExecuted Then

                    executeSearch(Me.query, False)

                End If

            Else
                'No querystring entered

                Me.ltrGoogleMiniSearchResults.Text = "No Query defined."

            End If


        End Sub

        Protected Sub txtSearch_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtSearch.PreRender
            txtSearch.Text = Me.query
        End Sub


#End Region

#Region "Private and Protected Methods"


        '''' <summary>
        '''' Laast nieuw Xsl document. Moet thread safe gebeuren. .Transform method is wel threadsafe.
        '''' </summary>
        '''' <param name="appRelativePath"></param>
        '''' <remarks></remarks>
        'Private Shared Sub loadXsl(ByVal appRelativePath As String)

        '	Try
        '		Dim xslPath As String = System.Web.VirtualPathUtility.ToAbsolute(appRelativePath)

        '		xslPath = System.Web.HttpContext.Current.Server.MapPath(xslPath)

        '		SyncLock ViewGoogleSearchResults.xslTransformerLock
        '			ViewGoogleSearchResults.xslTransformer.Load(xslPath)
        '		End SyncLock

        '	Catch ex As Exception

        '		'TODO Signal failure loading XSL

        '	End Try


        'End Sub

        ''' <summary>
        ''' Builds querystring for request to Google Mini server, performs request and transforms resulting XML
        ''' </summary>
        ''' <param name="query"></param>
        ''' <remarks>The resulting HTML is assigned to the <see cref="ltrGoogleMiniSearchResults">ltrGoogleMiniSearchResults.Text</see> property.</remarks>
        Private Sub executeSearch(ByVal query As String, ByVal isNewQuery As Boolean)

            Me.searchExecuted = True

            'Get list of valid parameters for GoogleMini
            '-------------------------------------------
            Dim validParamNames As Specialized.StringCollection = GoogleMiniParameterNames.ValidParameterNames

            'Pick up all querystring and form parameters and put then in one list. 
            'Form parameters supersede Querystring parameters.
            '---------------------------------------------------------------------
            Dim queryStringParameters As New System.Collections.Specialized.NameValueCollection(10)

            Dim querystringBuilder As New StringBuilder()

            For Each name As String In Request.Form
                If validParamNames.Contains(name) Then
                    If String.IsNullOrEmpty(queryStringParameters(name)) Then
                        queryStringParameters.Add(name, Request.Form(name))
                    End If
                End If
            Next

            For Each name As String In Request.QueryString
                If validParamNames.Contains(name) Then
                    queryStringParameters.Add(name, Request.QueryString(name))
                End If
            Next

            'Fill missing required parameters with their defaults
            '----------------------------------------------------
            'The searchcollection can never be taken from the querystring. This would be a security breach!!
            'Because then the form can be used to search any collection within the Google Mini box
            'So always override any site parameter in the querystring of form with the calculated valid searchCollecion as
            'dictated by the settings
            queryStringParameters(GoogleMiniParameterNames.Collection) = Me.searchCollection

            If String.IsNullOrEmpty(queryStringParameters(GoogleMiniParameterNames.FrontEndName)) Then
                queryStringParameters(GoogleMiniParameterNames.FrontEndName) = Me.defaultFrontEndField
            End If

            If String.IsNullOrEmpty(queryStringParameters(GoogleMiniParameterNames.NumberOfResults)) Then
                queryStringParameters(GoogleMiniParameterNames.NumberOfResults) = pageSize.ToString
            End If

            If String.IsNullOrEmpty(queryStringParameters(GoogleMiniParameterNames.StartOfPage)) Then
                queryStringParameters(GoogleMiniParameterNames.StartOfPage) = "0"
            End If

            'Force UTF-8 encoding
            queryStringParameters(GoogleMiniParameterNames.OutputEncoding) = "UTF-8"
            queryStringParameters(GoogleMiniParameterNames.InputEncoding) = "UTF-8"

            'Force output format
            queryStringParameters(GoogleMiniParameterNames.OuputFormat) = "xml_no_dtd"

            'Force query
            queryStringParameters(GoogleMiniParameterNames.Query) = query

            'Force start at first result for new queries
            If isNewQuery Then
                queryStringParameters(GoogleMiniParameterNames.StartOfPage) = "0"
            End If

            'Build the querystring to pass on to the GoogleMini
            '---------------------------------------------------
            For Each name As String In queryStringParameters
                Dim value As String = queryStringParameters(name)
                value = System.Web.HttpUtility.UrlEncode(value)
                If Not String.IsNullOrEmpty(value) Then
                    name = System.Web.HttpUtility.UrlEncode(name)

                    If querystringBuilder.Length > 0 Then
                        querystringBuilder.Append("&")
                    End If
                    querystringBuilder.Append(name)
                    querystringBuilder.Append("=")
                    querystringBuilder.Append(value)
                End If
            Next


            'Make the request to the google mini search applience
            '----------------------------------------------------
            Dim myRequest As System.Net.HttpWebRequest
            Dim urlBuilder As New UriBuilder

            urlBuilder.Query = querystringBuilder.ToString
            urlBuilder.Host = "google1.icatt.nl"
            urlBuilder.Path = "/search"
            urlBuilder.Port = 80
            urlBuilder.Scheme = System.Uri.UriSchemeHttp

            Dim url As Uri = urlBuilder.Uri

            Dim success As Boolean = False
            Dim response As Net.HttpWebResponse = Nothing

            myRequest = System.Net.HttpWebRequest.Create(url)
            myRequest.Timeout = 60 * 20 * 1000  ' 20 seconds

            Dim myXmlReader As System.Xml.XmlReader = Nothing

            Try

                response = CType(myRequest.GetResponse(), Net.HttpWebResponse)

                If response.StatusCode = Net.HttpStatusCode.OK Then
                    success = True

                    'Read the response only for debugging purposes
                    'Dim readStream As New System.IO.StreamReader(response.GetResponseStream(), True)

                    'Dim result As String = readStream.ReadToEnd
                    'readStream.Close()
                    'readStream.Dispose()
                Else
                    'TODO Signal failure
                End If

                Dim myTextReader As New System.IO.StreamReader(response.GetResponseStream)

                'Read the entire resopnse into a string
                Dim xml As String = myTextReader.ReadToEnd

                'Create a stringreader as the basic TextReader to be used by the XmlReader
                Dim myStringReader As New System.IO.StringReader(xml)


                'Create an XmlReader to be used by the  XslDocument.Transform method 
                myXmlReader = System.Xml.XmlReader.Create(myStringReader)

                'Create an XmlReader to be used by the  XslDocument.Transform method 
                'myXmlReader = System.Xml.XmlReader.Create(response.GetResponseStream)


                Dim xmlOut As New System.IO.StringWriter()
                Dim args As New System.Xml.Xsl.XsltArgumentList()

                'Reads the response and transforms it
                ViewGoogleSearchResults.xslTransformer.Transform(myXmlReader, args, xmlOut)

                Dim result As String = xmlOut.ToString

                If Not result Is Nothing Then result = result.Trim

                If String.IsNullOrEmpty(result) Then
                    Me.ltrGoogleMiniSearchResults.Text = Global.DotNetNuke.Services.Localization.Localization.GetString("NoResults.Text", Me.LocalResourceFile)
                End If

                Me.ltrGoogleMiniSearchResults.Text = xmlOut.ToString

            Catch ex As Exception

                'TODO log, display
                Dim msg As String = ex.Message
                Me.ltrGoogleMiniSearchResults.Text = msg
                'Error parsing the xml
            Finally
                If response IsNot Nothing Then response.Close()

                If myXmlReader IsNot Nothing Then
                    If (myXmlReader.ReadState And System.Xml.ReadState.Closed) <> System.Xml.ReadState.Closed Then
                        myXmlReader.Close()
                    End If
                End If

            End Try

            'TODO place xsl somwhere else. Portal specific. Only default xsl here
            'TODO replace fixed path with acutal control location

        End Sub


#End Region

#Region "Optional Interfaces"

        ''' -----------------------------------------------------------------------------
        ''' <summary>
        ''' Registers the module actions required for interfacing with the portal framework
        ''' </summary>
        ''' <value></value>
        ''' <returns></returns>
        ''' <remarks></remarks>
        ''' <history>
        ''' </history>
        ''' -----------------------------------------------------------------------------
        Public ReadOnly Property ModuleActions() As Actions.ModuleActionCollection Implements IActionable.ModuleActions
            Get
                Dim Actions As New Actions.ModuleActionCollection
                Actions.Add(GetNextActionID, Localization.GetString(Global.DotNetNuke.Entities.Modules.Actions.ModuleActionType.AddContent, LocalResourceFile), Global.DotNetNuke.Entities.Modules.Actions.ModuleActionType.AddContent, "", "", EditUrl(), False, Global.DotNetNuke.Security.SecurityAccessLevel.Edit, True, False)
                Return Actions
            End Get
        End Property

#End Region

#Region "Nested Types"


        Public Class GoogleMiniParameterNames

            Private Shared validParameterNamesField As Specialized.StringCollection

            'REQUIRED
            '========
            Public Shared ReadOnly FrontEndName As String = "client"
            'A string indicating any valid front end  

            Public Shared ReadOnly OuputFormat As String = "output"
            ' Select the format of the search results. Valid formats are:
            '	Value			Output Format  
            '	xml_no_dtd		XML results or custom HTML. (See proxystylesheet parameter for details.) 
            '	xml				XML results with Google DTD reference. If using this value, proxystylesheet must be omitted from the parameters or must be set to an empty string. 

            Public Shared ReadOnly Collection As String = "site"
            'The name of a collection. Note that you can search over multiple collections using the properly 
            'escaped OR (pipe character) to separate the collection names.  


            'OPTIONAL
            '========
            Public Shared ReadOnly Access As String = "access"                                  'default p
            'Defines whether the user is searching public content or all content (i.e. public and secure). 
            'This parameter takes effect only if Secured Content Search capability is enabled. 
            'The access parameter can have one of these possible values: 
            '  p - search public content 
            '  s - search secure content 
            '  a - search all content, both public and secure 
            'The access parameter defaults to "p" if none is provided. 
            'Note: Secured Content Search is automatically enabled for clustered appliances.

            Public Shared ReadOnly AdditionalSiteInclusion As String = "as_dt"                  'default i
            'Modifies the as_sitesearch parameter as follows: 
            'Value Modification 
            '	i	Include only results in the web directory specified by as_sitesearch  
            '	e	Exclude all results in the web directory specified by as_sitesearch  

            Public Shared ReadOnly AdditionalPhraseTerms As String = "as_epq"                   'default Empty string
            'Adds an additional search query term to search for the phrase specified. 
            'This parameter has the same effect as the phrase special query term. 
            'Note: New query terms specified will be combined with q query terms to generate search results.
            'Note: The value specified for this parameter must be URL-escaped. 

            Public Shared ReadOnly AdditionalExcludedTerms As String = "as_eq"                  'default Empty string  
            'Adds an additional search query terms to exclude any of the terms specified.
            'This parameter has the same effect as the exclude (-) special query term. 
            'Note: New query terms will be combined with q query terms to generate search results.
            'Note: The value specified for this parameter must be URL-escaped.  

            Public Shared ReadOnly AdditionalLinkedToUrl As String = "as_lq"                    'default Empty string  
            'Additional search query term to show any pages which link to the specified URL. 
            'This parameter has the same effect as the link special query term. 
            'Note: No other query terms can be specified when using this special query term.
            'Note: The value specified for this parameter must be URL-escaped.

            Public Shared ReadOnly AdditionalWhereInPage As String = "as_occt"                  'default Empty string  
            'Additional search query term to specify where the search terms occur on the page: 
            '	anywhere on the page, 
            '	in the title, 
            '	in the URL. 
            'Note: Query terms specified will be combined with q query terms to generate search results.
            'Note: The value specified for this parameter must be URL-escaped. 
            '	Value	Meaning
            '	------	------------------------
            '	any		anywhere on the page  
            '	title	in the title of the page  
            '	URL		in the URL for the page  

            Public Shared ReadOnly AdditionalOrTerms As String = "as_oq"                        'default Empty string  
            'Adds additional search query terms to find any of the terms specified. 
            'This parameter has the same effect as the OR special query term. 
            'Note: New query terms will be combined with q query terms to generate search results.
            'Note: The value specified for this parameter must be URL-escaped.  

            Public Shared ReadOnly AdditionalAndTerms As String = "as_q"                        'default Empty string  
            'Search query terms as entered by the user. 
            '(See Query Terms section for additional query features.)
            'Note: Query terms specified will be combined with q query terms to generate search results.
            'Note: The value specified for this parameter must be URL-escaped.

            Public Shared ReadOnly AdditionalSiteSearch As String = "as_sitesearch"             'default Empty string, max 119 characters
            'Additional search query term to show links in the specified web directory or to exclude those links depending on the value of as_dt. 
            'This parameter has the same effect as the site special query term. 
            'When the Google Search Appliance is sent a search request that includes the as_sitesearch parameter, it converts the value of the parameter into an argument to the site special query term and appends it to the value of q in the search results. 
            'For example, if your search contains the following parameters: 
            '    q=mycompany&as_sitesearch=www.mycompany.com 
            'The raw XML of your search results will contain the following: 
            '    <q>mycompany site:www.mycompany.com</q> 
            'The default XSLT stylesheet displays the value of the q tag in the search box on the results page. Consequently, using an as_sitesearch parameter will appear to change the user's search query. 
            'If the parameter and value as_dt=e are specified, -site: is appended to the end of the query term. 
            'Note: The value specified for this parameter must be URL-escaped and contain fewer than 119 characters.   


            Public Shared ReadOnly FilterEnabled As String = "filter"                           'default 1
            'Activates or deactivates automatic results filtering performed by Google search. By default, filtering is applied to all Google results returned to improve results quality.
            '(See Automatic Filtering section for more details.) 
            '	Values 
            '	1 (one - filtering enabled) or 
            '	0 (zero - all filtering disabled) or 
            '	p (disable Duplicate Snippet Filtering only) or 
            '	s (disable Duplicate Direcotry Filtering only)

            Public Shared ReadOnly MetaTagsToReturn As String = "getfields"                     'default Empty string
            'Requests that the names and values of the meta tags specified be returned with each search result, when available.
            '
            'Note:		All meta tag names or values specified must be double URL-escaped.  
            'Example:	GET /search?q=books&output=xml&client=[test]&site=[test]&getfields=author.title.keywords
            '			would return the first 10 results that match the query "books" in the "test" collection. If any of the results contain the author, title and/or keywords meta tags, then the values of those meta tags will be returned with the respective results. For example, the following tags could be returned with this search request:
            '			<META NAME="author" CONTENT="Jakob Nielsen">
            '			<META NAME="title" CONTENT="Usability Engineering">
            '			<META NAME="keywords" CONTENT="Usability, User Interface, User Feedback">


            Public Shared ReadOnly InputEncoding As String = "ie"                               'default latin1
            'Input Encoding
            'Sets the character encoding used to interpret the query string.

            Public Shared ReadOnly LanguageRestriction As String = "lr"                         'default Empty string
            'Language restrict
            'Restricts searches to pages in the specified language. 

            Public Shared ReadOnly NumberOfResults As String = "num"                            'default 10, mas 100
            'Number of results desired per a single request. The maximum allowable value is 100. (The maximum number of results available for a query is 1,000.) See also start. 
            'Note: The actual number of results may be smaller than the requested value.

            Public Shared ReadOnly NumberOfKeymatchResults As String = "numgm"                  'default 3. Between 0 and 5
            'Number of KeyMatch results to return with the results. A value between 0 to 5 (inclusive) can be specified for this option.
            '3

            Public Shared ReadOnly OutputEncoding As String = "oe"                              'default UTF-8
            'Output Encoding
            'Sets the character encoding used to encode the results returned.
            '(See Internationalization section for details.)  

            Public Shared ReadOnly FilterByPartialMetaData As String = "partialfields"          'default Empty string
            'Restricts the search results to documents with meta tags whose values contain the words or phrases specified.
            '(See Meta Tags section for more details.)
            'Note: All meta tag names or values specified must be double URL-escaped.  

            Public Shared ReadOnly IncludeCustomXmlTag As String = "proxycustom"                'default Empty string
            ' Custom XML tags to be included in the XML results. The only permitted values for this parameter are either 
            '	<HOME/>, 
            '	<ADVANCED/>, or 
            '	<TEST/>.
            '(See the Custom HTML output section for more details.)
            'Note: This parameter is disabled if the search request does not contain the proxystylesheet tag.
            'Note: If custom XML is specified, search results will not be returned with the search request.
            'Note: Custom XML must be URL-escaped. 

            Public Shared ReadOnly ReloadProxyXslt As String = "proxyreload"                    'default 0
            ' A value of 1 indicates that the Google Search Appliance should update the XSL stylesheet cache to refresh the stylesheet currently being requested. This parameter is optional. The XSL stylesheet cache is updated approximately every 15 minutes. 
            ' Values: 1 (force reload) or 0 (use cache)

            ''' <summary>
            ''' Select XSLT to be used by Front End Name. Only has effect when output = xml_no_dtd. 
            ''' </summary>
            ''' <remarks>
            ''' <para>If the value of the output parameter is xml_no_dtd, then the output format is modified by the proxystylesheet value as follows:</para>
            ''' <table>
            ''' <th><td>Proxystylesheet</td><td>Value Output Format</td></th>
            ''' <tr><td>Omitted</td><td>XML results</td></tr>
            ''' <tr><td>Empty</td><td>XML results have a content-type of text/html (rather than text/xml), because the XML results are not transformed.</td> </tr>
            ''' <tr><td>Front End Name</td><td>Custom HTML results through application of the XSL stylesheet associated with the specified front end</td></tr>
            ''' </table>
            ''' <para>(See the <a href="http://google1.icatt.nl:8000/EnterpriseController/xml_reference.html#results_xslt">HTML section</a> for more details.)<br/>
            ''' Note: This parameter may also specify the identifier of a valid collection. The default XSL stylesheet associated with that collection will then be used for custom HTML output.<br/>
            ''' Note: The value specified for this parameter must be URL-escaped.</para>
            ''' </remarks>
            Public Shared ReadOnly UseXsltOfFrontEnd As String = "proxystylesheet"              'No default

            Public Shared ReadOnly Query As String = "q"                                        'default Empty string
            ' Search query as entered by the user.
            '(See Query Terms section for additional query features.)
            'Note: The value specified for this parameter must be URL-escaped.  

            Public Shared ReadOnly FilterByMetaData As String = "requiredfields"                'default Empty string
            '  Restricts the search results to documents that contain exact meta tag names or name-value pairs specified.
            '(See Meta Tags section for more details.)
            'Note: All meta tag names or values specified must be double URL-escaped.  

            Public Shared ReadOnly SiteSearch As String = "sitesearch"                          'default Empty string
            ' Additional search query term to show links in the specified web directory. Requires that a value for q (query) be submitted as well. (The value of as_dt does not modify the effect of the sitesearch parameter.) 
            'This parameter has the same effect as the site special query term. 
            'Note: The sitesearch and as_sitesearch parameters differ in how they are returned in the XML results. The sitesearch parameter is not appended to the search query in the results. That is, the original query term will not be modified when you use the sitesearch parameter. 
            'Note: The value specified for this parameter must be URL-escaped.   

            Public Shared ReadOnly SortOrder As String = "sort"                                 'default Empty string
            ' Indicates alternate sorting method.
            '(See Sorting section for sort parameter format and details.)
            'Note: Only date sort is currently supported.

            Public Shared ReadOnly StartOfPage As String = "start"                              'default 0, max 1000
            'Use this parameter to support result set page navigation. The maximum number of results available for a query is 1,000, i.e., the value of the start parameter added to the value of the num parameter cannot exceed 1,000. See also num. 

            Private Sub New()

            End Sub


            Public Shared ReadOnly Property ValidParameterNames() As System.Collections.Specialized.StringCollection
                Get
                    If GoogleMiniParameterNames.validParameterNamesField Is Nothing Then


                        Dim paramNames As New System.Collections.Specialized.StringCollection

                        Dim mySelf As New GoogleMiniParameterNames()

                        Dim myType As System.Type = mySelf.GetType

                        Dim mySharedProperties As System.Reflection.FieldInfo() = myType.GetFields(BindingFlags.Public Or BindingFlags.Static Or BindingFlags.DeclaredOnly)

                        For Each field As FieldInfo In mySharedProperties
                            paramNames.Add(field.GetValue(Nothing))
                        Next

                        GoogleMiniParameterNames.validParameterNamesField = paramNames
                    End If

                    Return GoogleMiniParameterNames.validParameterNamesField

                End Get
            End Property

        End Class


#End Region


    End Class

End Namespace
