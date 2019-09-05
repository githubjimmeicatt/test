<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>
  <xsl:param name="CSSClass">breadcrumb</xsl:param>
  <xsl:param name="separator">&#32;/&#32;</xsl:param>
  <xsl:template match="/*">
    <xsl:apply-templates select="root" />
  </xsl:template>
  <xsl:template match="root">
    <ul class="nav nav--inline">
      <xsl:apply-templates select="//node[@breadcrumb=1]" />
    </ul>
  </xsl:template>
  <xsl:template match="node">
    <xsl:choose>
      <xsl:when test="@depth=0">
        <li>
          <a href="{@url}">
            <xsl:value-of select="@text" />
          </a>
        </li>
      </xsl:when>
      <xsl:otherwise>
        <li>
          <xsl:if test="@selected=1">
            <xsl:attribute name="class">
              <xsl:text>is-active</xsl:text>
            </xsl:attribute>
          </xsl:if>
          <a href="{@url}">
            <xsl:value-of select="@text" />
          </a>
        </li>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>