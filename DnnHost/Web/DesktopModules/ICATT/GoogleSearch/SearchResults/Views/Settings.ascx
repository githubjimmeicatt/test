<%@ Control Language="C#" AutoEventWireup="true" Inherits="Icatt.Dnn.Mvc.ViewUserControl" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Import Namespace="Icatt.Dnn.Extensions.GoogleSearch.Models" %>
<%
    var data = (SettingsModel)Model;
%>
<div class="mspsContent dnnClear">
    <h2 class="dnnFormSectionHead">
        <a class="dnnSectionExpanded">Basis Instellingen</a>
    </h2>
    <fieldset>
        <div class="dnnFormItem">
            <div class="dnnTooltip">
                <label for="<%= UniquePrefix + "DefaultCollection" %>">
                   <a class="dnnFormHelp"><span><%= Localization.GetString("DefaultCollectionLabel",LocalResourceFileRoot)  %>:</span></a>
                </label>
                <div class="dnnFormHelpContent dnnClear" style="display: none;">
                    <span class="dnnHelpText"><%= Localization.GetString("DefaultCollectionLabel.Help",LocalResourceFileRoot)  %></span>
                    <a href="#" class="pinHelp"></a>
                </div>
            </div>
 		    <input id='<%= UniquePrefix + "DefaultCollection" %>' value="<%: data.DefaultCollection %>" name='<%= UniquePrefix + "DefaultCollection" %>' maxlength="1000"   />
        </div>
        <div class="dnnFormItem">
            <div class="dnnTooltip">
                <label for="<%= UniquePrefix + "FrontEnd" %>">
                   <a class="dnnFormHelp"><span><%= Localization.GetString("FrontEndLabel",LocalResourceFileRoot)  %>:</span></a>
                </label>
                <div class="dnnFormHelpContent dnnClear" style="display: none;">
                    <span class="dnnHelpText"><%= Localization.GetString("FrontEndLabel.Help",LocalResourceFileRoot)  %></span>
                    <a href="#" class="pinHelp"></a>
                </div>
            </div>
 		    <input id='Text1' value="<%: data.FrontEnd %>" name='<%= UniquePrefix + "FrontEnd" %>' maxlength="1000"   />
        </div>
        <div class="dnnFormItem">
            <div class="dnnTooltip">
                <label for="<%= UniquePrefix + "PageSize" %>">
                   <a class="dnnFormHelp"><span><%= Localization.GetString("PageSizeLabel",LocalResourceFileRoot)  %>:</span></a>
                </label>
                <div class="dnnFormHelpContent dnnClear" style="display: none;">
                    <span class="dnnHelpText"><%= Localization.GetString("PageSizeLabel.Help",LocalResourceFileRoot)  %></span>
                    <a href="#" class="pinHelp"></a>
                </div>
            </div>
 		    <input id='Text2' value="<%: data.PageSize %>" name='<%= UniquePrefix + "PageSize" %>' maxlength="1000"   />
        </div>
    </fieldset>
        <h2 class="dnnFormSectionHead">
        <a href >Geavanceerde Instellingen</a>
    </h2>
    <fieldset style="display: none;">
        <div class="dnnFormItem">
            <div class="dnnFormMessage">
			
            </div>
            <div class="dnnTooltip">
                <label for="<%= UniquePrefix + "RoleCollections" %>">
                   <a class="dnnFormHelp"><span><%= Localization.GetString("RoleCollectionsLabel",LocalResourceFileRoot)  %>:</span></a>
                </label>
                <div class="dnnFormHelpContent dnnClear" style="display: none;">
                    <span class="dnnHelpText"><%= Localization.GetString("RoleCollectionsLabel.Help",LocalResourceFileRoot)  %></span>
                    <a href="#" class="pinHelp"></a>
                </div>
            </div>
 		    <textarea id="<%= UniquePrefix + "RoleCollections" %>" 
                 name='<%= UniquePrefix + "RoleCollections" %>' maxlength="10000"><%: data.RoleCollections %></textarea>
        </div>
    </fieldset>

</div>
