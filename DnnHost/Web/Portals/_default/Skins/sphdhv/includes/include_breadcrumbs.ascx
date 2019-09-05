<div class="page__breadcrumbs">
    
    <div class="page__breadcrumbs__inner">

        <%If PortalSettings.ActiveTab.Level > 0 Then%>

        <a href="<%=PortalSettings.ActiveTab.BreadCrumbs(PortalSettings.ActiveTab.Level - 1).FullUrl %>" class="mobile-back-link"><%=PortalSettings.ActiveTab.BreadCrumbs(PortalSettings.ActiveTab.Level - 1).TabName %></a>

        <% End If%>

        <dnn:menu id="NAVCRUMB" runat="server" menustyle="navigation/nav-breadcrumb" rootlevel="0" IncludeHidden="true" />

    </div>
    
</div>