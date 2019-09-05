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
Imports System.Web.UI
Imports ModuleSettingNames = Icatt.DotNetNuke.Modules.GoogleSearchResults.GoogleSearchResultsController.ModuleSettingNames
Imports DotNetNuke.Entities.Modules
Imports DotNetNuke.Security.Roles

Namespace Icatt.DotNetNuke.Modules.GoogleSearchResults

    ''' -----------------------------------------------------------------------------
    ''' <summary>
    ''' The Settings class manages Module Settings
    ''' </summary>
    ''' <remarks>
    ''' </remarks>
    ''' <history>
    ''' </history>
    ''' -----------------------------------------------------------------------------
    Partial Class Settings
        Inherits ModuleSettingsBase

#Region "Base Method Implementations"

        ''' -----------------------------------------------------------------------------
        ''' <summary>
        ''' LoadSettings loads the settings from the Database and displays them
        ''' </summary>
        ''' <remarks>
        ''' </remarks>
        ''' <history>
        ''' </history>
        ''' -----------------------------------------------------------------------------
        Public Overrides Sub LoadSettings()
            Try
                If (Not Me.IsPostBack) Then
                    If CType(TabModuleSettings(ModuleSettingNames.DefaultCollection), String) <> "" Then
                        Me.txtDefaultCollection.Text = CType(TabModuleSettings(ModuleSettingNames.DefaultCollection), String)
                    End If

                    If TabModuleSettings.ContainsKey(ModuleSettingNames.DefaultPageSize) Then
                        Me.txtDefaultPageSize.Text = CType(TabModuleSettings(ModuleSettingNames.DefaultPageSize), String)
                    End If

                    If CType(TabModuleSettings(ModuleSettingNames.DefaultFrontEndName), String) <> "" Then
                        Me.txtDefaultFrontEndName.Text = CType(TabModuleSettings(ModuleSettingNames.DefaultFrontEndName), String)
                    End If

                    If CType(TabModuleSettings(ModuleSettingNames.RoleCollections), String) <> "" Then
                        Me.txtRoleBasedCollections.Text = CType(TabModuleSettings(ModuleSettingNames.RoleCollections), String)
                    End If


                End If
            Catch exc As Exception           'Module failed to load
                ProcessModuleLoadException(Me, exc)
            End Try
        End Sub

        ''' -----------------------------------------------------------------------------
        ''' <summary>
        ''' UpdateSettings saves the modified settings to the Database
        ''' </summary>
        ''' <remarks>
        ''' </remarks>
        ''' <history>
        ''' </history>
        ''' -----------------------------------------------------------------------------
        Public Overrides Sub UpdateSettings()

            Page.Validate("Icatt.GoogleMiniSettings")

            If Page.IsValid Then

                Try
                    Dim objModules As New ModuleController

                    objModules.UpdateTabModuleSetting(TabModuleId, ModuleSettingNames.RoleCollections, txtRoleBasedCollections.Text)
                    objModules.UpdateTabModuleSetting(TabModuleId, ModuleSettingNames.DefaultCollection, txtDefaultCollection.Text)
                    objModules.UpdateTabModuleSetting(TabModuleId, ModuleSettingNames.DefaultFrontEndName, txtDefaultFrontEndName.Text)

                    Dim pageSize As Int32
                    If Not Int32.TryParse(txtDefaultPageSize.Text, pageSize) Then
                        pageSize = 25
                    End If
                    objModules.UpdateTabModuleSetting(TabModuleId, ModuleSettingNames.DefaultPageSize, pageSize)

                    ' refresh cache
                    ModuleController.SynchronizeModule(Me.ModuleId)

                Catch exc As Exception           'Module failed to load
                    ProcessModuleLoadException(Me, exc)
                End Try

            End If

        End Sub

#End Region


        '	Protected Sub btnReloadXsl_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReloadXsl.Click

        '		If Not GoogleSearchResultsController.ReloadXsl() Then
        '			lblReloadFailed.Visible = True
        '		Else
        '			lblReloadFailed.Visible = False
        '		End If

        '	End Sub

        '	<tr>
        '	<td class="SubHead" width="150">
        '		<dnn:Label id="lblReloadXsl" runat="server" controlname="btnReloadXsl"
        '			suffix=":"></dnn:Label>
        '	</td>
        '	<td valign="bottom">
        '		<asp:Button causesvalidation="true" id="btnReloadXsl" runat="server" text="Reload XSL Stylesheet"  />
        '		<asp:Label id="lblReloadFailed" runat="server" style="color:Red;" visible="false" text="Reload failed." />
        '	</td>
        '</tr>

        Protected Sub valRoleBasedCollections_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles valRoleBasedCollections.ServerValidate
            Try
                args.IsValid = True
                Dim roleList As String() = args.Value.Split(New String() {";"}, StringSplitOptions.RemoveEmptyEntries)
                Dim cleanValue As String = ""
                For Each collList As String In roleList
                    collList = collList.Trim
                    Dim cleanRole As String
                    Dim collArray As String() = collList.Split(New String() {","}, StringSplitOptions.RemoveEmptyEntries)
                    If collArray.Length >= 1 Then
                        Dim role As String = collArray(0).Trim
                        'Chechk whether role is valid
                        Dim info As RoleInfo = DNNRoleProvider.Instance.GetRole(PortalSettings.PortalId, role)
                        If info Is Nothing Then
                            'Check for system roles
                            Select Case role.ToLowerInvariant
                                Case "authenticated", "unauthenticated"
                                Case Else
                                    args.IsValid = False
                                    Dim msg As String = Localization.GetString("valRoleBasedCollections.InvalidRole", Me.LocalResourceFile)
                                    msg = String.Format(msg, role)
                                    Me.valRoleBasedCollections.Text = msg
                                    Exit Sub
                            End Select
                        End If

                        Dim cleanColl As String = ""
                        For i As Int32 = 1 To collArray.Length - 1
                            Dim coll As String = collArray(i).Trim
                            'No special requirements for collection names at this point
                            If cleanColl.Length > 0 Then cleanColl += ","
                            cleanColl += coll
                        Next
                        cleanRole = String.Concat(role, ",", cleanColl)
                    Else
                        args.IsValid = False
                        Me.valRoleBasedCollections.Text = Localization.GetString("valRoleBasedCollections.InvalidFormat", Me.LocalResourceFile)
                        Exit Sub
                    End If

                    If cleanValue.Length > 1 Then cleanValue = String.Concat(cleanValue, ";")

                    cleanValue = String.Concat(cleanValue, cleanRole)
                Next

                Me.txtRoleBasedCollections.Text = cleanValue
            Catch
                args.IsValid = False
                Me.valRoleBasedCollections.Text = Localization.GetString("valRoleBasedCollections.InvalidFormat", Me.LocalResourceFile)

            End Try

        End Sub
    End Class

End Namespace

