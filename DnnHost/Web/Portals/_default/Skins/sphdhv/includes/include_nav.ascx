<div class="page__nav" id="pageNav">
    
    <div class="page__nav__inner">

        <dnn:MENU ID="mainNav" MenuStyle="navigation/nav-main" NodeSelector="RootChildren" runat="server"></dnn:MENU>

        <!--

        <div class="search">
            
            <input type="text" placeholder="Zoeken op deze site" />
            
        </div>

        -->

    <div class="search hidden-xs">
                        <dnn:SEARCH ID="dnnSearch" runat="server" ShowSite="false" ShowWeb="false" autocomplete="off" UseDropDownList="false" EnableTheming="true" Submit="Zoeken" CssClass="SearchButton" />
                    </div>


    </div>

</div>

<style>

#dnn_dnnSearch_cmdSearch { display: none !important; }
.searchSkinObjectPreview { display: none !important; }

</style>