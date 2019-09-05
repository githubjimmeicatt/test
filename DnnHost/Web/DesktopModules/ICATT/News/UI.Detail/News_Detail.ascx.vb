

Namespace DesktopModules.ICATT.News.UI.Detail

	Partial Class News_Detail
		Inherits Global.Icatt.DotNetNuke.Modules.News.UI.Detail.News_Detail

		Protected Sub Page_Init(sender As Object, e As System.EventArgs) Handles Me.Init


			'Modify title used in breadcrumb in Init 
			Dim objTab = CType(PortalSettings.ActiveTab.BreadCrumbs(PortalSettings.ActiveTab.BreadCrumbs.Count - 1), Global.DotNetNuke.Entities.Tabs.TabInfo)

			objTab.TabName = NewsItem.Title

		End Sub


		Private Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender


			'find parent skin 
			Dim ctl = Me.Parent

			While Not ctl Is Nothing AndAlso Not TypeOf ctl Is Global.DotNetNuke.UI.Skins.Skin
				ctl = ctl.Parent
			End While

			If Not ctl Is Nothing Then
				Dim phTitle = ctl.FindControl("phPageTitle")


				If Not phTitle Is Nothing Then
					If TypeOf phTitle Is HtmlGenericControl Then
						CType(phTitle, HtmlGenericControl).InnerHtml = NewsItem.Title
					End If

				End If
			End If

		End Sub

	End Class
End Namespace
