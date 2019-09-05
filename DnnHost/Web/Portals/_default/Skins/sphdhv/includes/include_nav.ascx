<div class="page__nav" id="pageNav">
    
    <div class="page__nav__inner">

        <dnn:MENU ID="mainNav" MenuStyle="navigation/nav-main" NodeSelector="RootChildren" runat="server"></dnn:MENU>

        <!--

        <div class="search">
            
            <input type="text" placeholder="Zoeken op deze site" />
            
        </div>

        -->

        <div class="search">

            <dnn:SEARCH runat="server" ShowWeb="false" ShowSite="true" UseDropDownList="false" EnableWildSearch="false" AutoSearchDelayInMilliSecond="100000" MinCharRequired="100" />

        </div>

    </div>

</div>