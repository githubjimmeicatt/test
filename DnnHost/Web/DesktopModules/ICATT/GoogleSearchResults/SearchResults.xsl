<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>

  <!-- **********************************************************************
	***************************************************************************
    VARIABLE DECLARTIONS
	***************************************************************************
    *********************************************************************** -->

  <!-- **********************************************************************
 Result page components (can be customized)
     - whether to show a component: 0 for FALSE, non-zero (e.g., 1) for TRUE
     - text and style
     ********************************************************************** -->
  <!-- *** choose search button type: 'text' or 'image' *** -->
  <xsl:variable name="search_collections_xslt">1</xsl:variable>


  <!-- *** db_url_protocol: googledb:// *** -->
  <xsl:variable name="db_url_protocol">googledb://</xsl:variable>

  <!-- *** link URL *** -->
  <xsl:variable name="truncate_result_url_length">100</xsl:variable>
  <xsl:variable name="show_res_url">1</xsl:variable>

  <!-- *** navigation bars: '', 'google', 'link', or 'simple'*** -->
  <xsl:variable name="choose_bottom_navigation">simple</xsl:variable>


  <!-- **********************************************************************
 URL variables (do not customize)
     ********************************************************************** -->
  <!-- *** if this is a test search (help variable)-->
  <xsl:variable name="is_test_search"
	  select="/GSP/PARAM[@name='testSearch']/@value"/>

  <!-- *** search_url *** -->
  <xsl:variable name="search_url">
    <xsl:for-each select="/GSP/PARAM[(@name != 'start') and
                                   (@name != 'swrnum') and
                     (@name != 'epoch' or $is_test_search != '') and
                     not(starts-with(@name, 'metabased_'))]">
      <xsl:value-of select="@name"/>
      <xsl:text>=</xsl:text>
      <xsl:value-of select="@original_value"/>
      <xsl:if test="position() != last()">
        <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>
  <xsl:variable name="truncate_result_urls">1</xsl:variable>

  <!-- *** result title and snippet *** -->
  <xsl:variable name="show_res_title">1</xsl:variable>
  <xsl:variable name="show_res_snippet">1</xsl:variable>

  <!-- **********************************************************************
  Variables for reformatting keyword-match display (do not customize)
     ********************************************************************** -->
  <xsl:variable name="keyword_orig_start" select="'&lt;b&gt;'"/>
  <xsl:variable name="keyword_orig_end" select="'&lt;/b&gt;'"/>
  <xsl:variable name="keyword_reformat_start">
    <xsl:if test="$res_keyword_format">
      <xsl:text>&lt;</xsl:text>
      <xsl:value-of select="$res_keyword_format"/>
      <xsl:text>&gt;</xsl:text>
    </xsl:if>
    <xsl:if test="($res_keyword_size) or ($res_keyword_color)">
      <xsl:text>&lt;font</xsl:text>
      <xsl:if test="$res_keyword_size">
        <xsl:text> size="</xsl:text>
        <xsl:value-of select="$res_keyword_size"/>
        <xsl:text>"</xsl:text>
      </xsl:if>
      <xsl:if test="$res_keyword_color">
        <xsl:text> color="</xsl:text>
        <xsl:value-of select="$res_keyword_color"/>
        <xsl:text>"</xsl:text>
      </xsl:if>
      <xsl:text>&gt;</xsl:text>
    </xsl:if>
  </xsl:variable>
  <xsl:variable name="keyword_reformat_end">
    <xsl:if test="($res_keyword_size) or ($res_keyword_color)">
      <xsl:text>&lt;/font&gt;</xsl:text>
    </xsl:if>
    <xsl:if test="$res_keyword_format">
      <xsl:text>&lt;/</xsl:text>
      <xsl:value-of select="$res_keyword_format"/>
      <xsl:text>&gt;</xsl:text>
    </xsl:if>
  </xsl:variable>

  <!-- *** keyword match (in title or snippet) *** -->
  <xsl:variable name="res_keyword_color"></xsl:variable>
  <xsl:variable name="res_keyword_size"></xsl:variable>
  <xsl:variable name="res_keyword_format">span</xsl:variable>

  <!-- *** misc elements *** -->
  <xsl:variable name="show_meta_tags">0</xsl:variable>
  <xsl:variable name="show_res_size">0</xsl:variable>
  <xsl:variable name="show_res_date">0</xsl:variable>
  <xsl:variable name="show_res_cache">0</xsl:variable>

  <!-- **********************************************************************
 Search Parameters (do not customize)
     ********************************************************************** -->
  <!-- *** num_results: actual num_results per page *** -->
  <xsl:variable name="num_results">
    <xsl:choose>
      <xsl:when test="/GSP/PARAM[(@name='num') and (@value!='')]">
        <xsl:value-of select="/GSP/PARAM[@name='num']/@value"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="10"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- *** form_params: parameters carried by the search input form *** -->
  <xsl:template name="form_params">
    <xsl:for-each
		  select="PARAM[@name != 'q' and
                  @name != 'ie' and
                  not(contains(@name, 'as_')) and
                  @name != 'btnG' and
                  @name != 'btnI' and
                  @name != 'site' and
                  @name != 'filter' and
                  @name != 'swrnum' and
                  @name != 'start' and
                  @name != 'access' and
                  @name != 'ip' and
                  (@name != 'epoch' or $is_test_search != '') and
                  not(starts-with(@name ,'metabased_'))]">
      <input type="hidden" name="{@name}" value="{@value}" />

      <xsl:if test="@name = 'oe'">
        <input type="hidden" name="ie" value="{@value}" />
      </xsl:if>
      <xsl:text>
    </xsl:text>
    </xsl:for-each>
    <xsl:if test="$search_collections_xslt = '' and PARAM[@name='site']">
      <input type="hidden" name="site" value="{PARAM[@name='site']/@value}"/>
    </xsl:if>
  </xsl:template>

  <!-- *** space_normalized_query: q = /GSP/Q *** -->
  <xsl:variable name="qval">
    <xsl:value-of select="/GSP/Q"/>
  </xsl:variable>

  <xsl:variable name="space_normalized_query">
    <xsl:value-of select="normalize-space($qval)"
		  disable-output-escaping="yes"/>
  </xsl:variable>

  <!-- *** stripped_search_query: q, as_q, ... for cache highlight *** -->
  <xsl:variable name="stripped_search_query">
    <xsl:for-each
  select="/GSP/PARAM[(@name = 'q') or
                     (@name = 'as_q') or
                     (@name = 'as_oq') or
                     (@name = 'as_epq')]">
      <xsl:value-of select="@original_value"
  />
      <xsl:if test="position() != last()"
    >
        <xsl:text disable-output-escaping="yes">+</xsl:text
     >
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>

  <xsl:variable name="access">
    <xsl:choose>
      <xsl:when test="/GSP/PARAM[(@name='access') and ((@value='s') or (@value='a'))]">
        <xsl:value-of select="/GSP/PARAM[@name='access']/@original_value"/>
      </xsl:when>
      <xsl:otherwise>p</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>


  <!-- ************************************************************************
	*****************************************************************************
	START TRANSFORMATION TEMPLATES 
	*****************************************************************************
	**************************************************************************-->

  <!-- **********************************************************************
 Figure out what kind of page this is (do not customize)
     ********************************************************************** -->
  <xsl:template match="GSP">
    <xsl:choose>
      <xsl:when test="Q">
        <xsl:call-template name="search_results"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>


  <!-- *** Handle results (if any) *** -->
  <xsl:template name="search_results">
    <xsl:choose>
      <xsl:when test="RES or GM or Spelling or Synonyms or CT">
        <xsl:call-template name="results">
          <xsl:with-param name="query" select="Q"/>
          <xsl:with-param name="time" select="TM"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="Q=''">
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="no_RES">
          <xsl:with-param name="query" select="Q"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template name="results">
    <!--
        This is an XSLT template file. Fill in this area with the
        XSL elements which will transform your XML to XHTML.
    -->
    <!-- *** Add bottom navigation *** -->
    <xsl:variable name="nav_style">
      <xsl:choose>
        <xsl:when test="($access='s') or ($access='a')">simple</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$choose_bottom_navigation"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- Top Page Navigation -->
    <xsl:call-template name="google_navigation">
      <xsl:with-param name="prev" select="RES/NB/PU"/>
      <xsl:with-param name="next" select="RES/NB/NU"/>
      <xsl:with-param name="view_begin" select="RES/@SN"/>
      <xsl:with-param name="view_end" select="RES/@EN"/>
      <xsl:with-param name="guess" select="RES/M"/>
      <xsl:with-param name="navigation_style" select="$nav_style"/>
    </xsl:call-template>


    <!-- result table start -->
    <ol class="list search_results">
      <xsl:apply-templates select="RES/R">
        <xsl:with-param name="query" select="Q"/>
      </xsl:apply-templates>
    </ol>
    <!-- result table END -->

    <!-- Bottom Page Navigation -->
    <xsl:call-template name="google_navigation">
      <xsl:with-param name="prev" select="RES/NB/PU"/>
      <xsl:with-param name="next" select="RES/NB/NU"/>
      <xsl:with-param name="view_begin" select="RES/@SN"/>
      <xsl:with-param name="view_end" select="RES/@EN"/>
      <xsl:with-param name="guess" select="RES/M"/>
      <xsl:with-param name="navigation_style" select="$nav_style"/>
    </xsl:call-template>

  </xsl:template>

  <xsl:template match="R">
    <xsl:param name="query"/>


    <xsl:variable name="display_url_tmp" select="substring-after(UD, '://')"/>
    <xsl:variable name="display_url">
      <xsl:choose>
        <xsl:when test="$display_url_tmp">
          <xsl:value-of select="$display_url_tmp"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring-after(U, '://')"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="escaped_url" select="substring-after(UE, '://')"/>
    <xsl:variable name="protocol" select="substring-before(U, '://')"/>
    <xsl:variable name="full_url" select="UE"/>
    <xsl:variable name="crowded_url" select="HN/@U"/>
    <xsl:variable name="crowded_display_url" select="HN"/>
    <xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyz'"/>
    <xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>

    <xsl:variable name="temp_url" select="substring-after(U, '://')"/>
    <xsl:variable name="url_indexed" select="not(starts-with($temp_url, 'noindex!/'))"/>
    <xsl:variable name="stripped_url">
      <xsl:choose>
        <xsl:when test="$truncate_result_urls != '0'">
          <xsl:call-template name="truncate_url">
            <xsl:with-param name="t_url" select="$display_url"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$display_url"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- start zoekresultaat regel -->
    <li>

      <!-- *** Indent as required (only supports 2 levels) ***
					<xsl:if test="@L='2'">
						<xsl:text disable-output-escaping="yes">&lt;blockquote class=&quot;g&quot;&gt;</xsl:text>
					</xsl:if> -->

      <!-- *** Result Header *** -->

      <!-- *** Result Title (including PDF tag and hyperlink) *** -->
      <xsl:if test="$show_res_title != '0'">
        <xsl:text disable-output-escaping='yes'>&lt;h2&gt;</xsl:text>

        <xsl:if test="$url_indexed">

          <xsl:text disable-output-escaping='yes'>&lt;a href="</xsl:text>
          <xsl:choose>
            <!-- *** URI for smb or NFS must be escaped because it appears in the URI query *** -->
            <xsl:when test="$protocol='smb' or $protocol='nfs'">
              <xsl:value-of disable-output-escaping='yes'
              select="concat($protocol,'/',
          substring-after(U,'://'))"/>
            </xsl:when>
            <xsl:when test="starts-with(U, $db_url_protocol)">
              <xsl:value-of disable-output-escaping='yes'
              select="concat('db/',
          substring-after(U,'://'))"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of disable-output-escaping='yes' select="U"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:text disable-output-escaping='yes'>"&gt;</xsl:text>

        </xsl:if>


        <xsl:choose>
          <xsl:when test="T">
            <!-- Title availeble -->
            <xsl:call-template name="reformat_keyword">
              <xsl:with-param name="orig_string" select="T"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <!-- No Title availeble, use stripped url -->
            <xsl:value-of select="$stripped_url"/>
          </xsl:otherwise>
        </xsl:choose>

        <xsl:if test="$url_indexed">
          <xsl:text disable-output-escaping='yes'>&lt;/a&gt;</xsl:text>
        </xsl:if>

        <span class='doctype'>

          <xsl:choose>
            <xsl:when test="@MIME='text/html' or @MIME='' or not(@MIME)"></xsl:when>
            <xsl:when test="@MIME='text/plain'">[TEXT]</xsl:when>
            <xsl:when test="@MIME='application/rtf'">[RTF]</xsl:when>
            <xsl:when test="@MIME='application/pdf'">[PDF]</xsl:when>
            <xsl:when test="@MIME='application/postscript'">[PS]</xsl:when>
            <xsl:when test="@MIME='application/vnd.ms-powerpoint'">[MS POWERPOINT]</xsl:when>
            <xsl:when test="@MIME='application/vnd.ms-excel'">[MS EXCEL]</xsl:when>
            <xsl:when test="@MIME='application/msword'">[MS WORD]</xsl:when>
            <xsl:otherwise>
              <xsl:variable name="extension">
                <xsl:call-template name="last_substring_after">
                  <xsl:with-param name="string" select="substring-after(
                                                  substring-after(U,'://'),
                                                  '/')"/>
                  <xsl:with-param name="separator" select="'.'"/>
                  <xsl:with-param name="fallback" select="'UNKNOWN'"/>
                </xsl:call-template>
              </xsl:variable>
              [<xsl:value-of select="translate($extension,$lower,$upper)"/>]
            </xsl:otherwise>
          </xsl:choose>
        </span>
        <xsl:text> </xsl:text>        
        
        <xsl:text disable-output-escaping='yes'>&lt;/h2&gt;</xsl:text>

      </xsl:if>    

      <!-- *** Snippet Box *** -->
      <p>
          <xsl:if test="$show_res_snippet != '0'">
          <!-- function call to highlight keyword -->
          <xsl:call-template name="reformat_keyword">
            <xsl:with-param name="orig_string" select="S"/>
          </xsl:call-template>
        </xsl:if>
        <!-- *** Meta tags *** -->
        <xsl:if test="$show_meta_tags != '0'">
          <xsl:apply-templates select="MT"/>
        </xsl:if>
      </p>

      <!-- *** URL *** -->
      <p class="details">
        <xsl:choose>
          <xsl:when test="not($url_indexed)">
            <xsl:if test="($show_res_size!='0') or
                        ($show_res_date!='0') or
                        ($show_res_cache!='0')">
              <xsl:text>Not Indexed:</xsl:text>
              <xsl:value-of select="$stripped_url"/>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="$show_res_url != '0'">
              <xsl:value-of select="$stripped_url"/>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
      </p>

      <!-- *** Miscellaneous (- size - date - cache) *** -->
      <xsl:if test="$url_indexed">
        <xsl:apply-templates select="HAS/C">
          <xsl:with-param name="stripped_url" select="$stripped_url"/>
          <xsl:with-param name="escaped_url" select="$escaped_url"/>
          <xsl:with-param name="query" select="$query"/>
          <xsl:with-param name="mime" select="@MIME"/>
          <xsl:with-param name="date" select="FS[@NAME='date']/@VALUE"/>
        </xsl:apply-templates>
      </xsl:if>


      <!-- *** Link to more links from this site *** 
					<xsl:if test="HN">
						<span class="VenexusSearch_Desc" style="font-size:12px;">
							[
							<a  style="font-size:12px" href="/searchesults.aspx?as_sitesearch={$crowded_url}&amp;{$search_url}">
								More results from <xsl:value-of select="$crowded_display_url"/>
							</a>
							]
						</span>

					</xsl:if>-->


      <!-- *** Result Footer *** -->

      <!-- *** End indenting as required (only supports 2 levels) *** 
					<xsl:if test="@L='2'">
						<xsl:text disable-output-escaping="yes">&lt;/blockquote&gt;</xsl:text>
					</xsl:if>-->

    </li>
    <!-- eind zoekresultaat regel -->

  </xsl:template>


  <!-- **********************************************************************
	***************************************************************************
    FUNCTIONS
	***************************************************************************
    *********************************************************************** -->

  <!-- **********************************************************************
 Helper templates for generating Google result navigation (do not customize)
   only shows 10 sets up or down from current view
     ********************************************************************** -->
  <xsl:template name="result_nav">
    <xsl:param name="start" select="'0'"/>
    <xsl:param name="end"/>
    <xsl:param name="current_view"/>
    <xsl:param name="navigation_style"/>

    <!-- *** Choose how to show this result set *** -->
    <xsl:choose>
      <xsl:when test="($start)&lt;(($current_view)-(10*($num_results)))">
      </xsl:when>
      <xsl:when test="(($current_view)&gt;=($start)) and
                    (($current_view)&lt;(($start)+($num_results)))">
        <td class="ActivePageNavPageNr">
          <xsl:if test="$navigation_style = 'google'">
            <img src="/nav_current.gif" width="16" height="26" alt="Current"/>
            <br/>
          </xsl:if>
          <xsl:if test="$navigation_style = 'link'">
            <xsl:call-template name="nbsp"/>
          </xsl:if>
          <span class="ActivePageNavPageNr">
            <xsl:value-of
          select="(($start)div($num_results))+1"/>
          </span>
          <xsl:if test="$navigation_style = 'link'">
            <xsl:call-template name="nbsp"/>
          </xsl:if>
        </td>
      </xsl:when>
      <xsl:otherwise>
        <td>
          <xsl:if test="$navigation_style = 'link'">
            <xsl:call-template name="nbsp"/>
          </xsl:if>
          <a class="PageNavPageNr"  href="zoekresultaten.aspx?{$search_url}&amp;start={$start}">
            <xsl:if test="$navigation_style = 'google'">
              <img src="/nav_page.gif" width="16" height="26" alt="Navigation"
								 border="0"/>
              <br/>
            </xsl:if>
            <xsl:value-of select="(($start)div($num_results))+1"/>
          </a>
          <xsl:if test="$navigation_style = 'link'">
            <xsl:call-template name="nbsp"/>
          </xsl:if>
        </td>
      </xsl:otherwise>
    </xsl:choose>

    <!-- *** Recursively iterate through result sets to display *** -->
    <xsl:if test="((($start)+($num_results))&lt;($end)) and
                ((($start)+($num_results))&lt;(($current_view)+
                (10*($num_results))))">
      <xsl:call-template name="result_nav">
        <xsl:with-param name="start" select="$start+$num_results"/>
        <xsl:with-param name="end" select="$end"/>
        <xsl:with-param name="current_view" select="$current_view"/>
        <xsl:with-param name="navigation_style" select="$navigation_style"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>



  <!-- **********************************************************************
 Google navigation bar in result page (do not customize)
     ********************************************************************** -->
  <xsl:template name="google_navigation">
    <xsl:param name="prev"/>
    <xsl:param name="next"/>
    <xsl:param name="view_begin"/>
    <xsl:param name="view_end"/>
    <xsl:param name="guess"/>
    <xsl:param name="navigation_style"/>

    <xsl:variable name="fontclass">
      <xsl:choose>
        <xsl:when test="$navigation_style = 'top'">s</xsl:when>
        <xsl:otherwise>b</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- *** Test to see if we should even show navigation *** -->
    <xsl:if test="($prev) or ($next)">

      <!-- *** Start Google result navigation bar *** -->

      <xsl:if test="$navigation_style != 'top'">
        <xsl:text disable-output-escaping="yes">
        &lt;div class=&quot;n&quot;&gt;</xsl:text>
      </xsl:if>
          <!--
					<xsl:if test="$navigation_style != 'top'">
						<td valign="bottom" nowrap="1">
							<span class="PageNavResultPage">
								Page<xsl:call-template name="nbsp"/>
							</span>
						</td>
					</xsl:if>
-->
          <!-- *** Show previous navigation, if available *** -->
          <xsl:choose>
            <xsl:when test="$prev">
                <span class="PageNavPrevious">
                  <a href="zoekresultaten.aspx?{$search_url}&amp;start={$view_begin -
                      $num_results - 1}">
                    <xsl:if test="$navigation_style = 'google'">

                      <img src="/nav_previous.gif" width="68" height="26"
											  alt="Vorige" border="0"/>
                      <br/>
                    </xsl:if>
                    <xsl:if test="$navigation_style = 'top'">
                      <xsl:text>&lt;</xsl:text>
                    </xsl:if>
                    <xsl:text>Vorige</xsl:text>
                  </a>
                </span>
                <xsl:if test="$navigation_style != 'google'">
                  <xsl:call-template name="nbsp"/>
                </xsl:if>
             
            </xsl:when>
            <xsl:otherwise>
              
                <xsl:if test="$navigation_style = 'google'">
                  <img src="/nav_first.gif" width="18" height="26"
									  alt="First" border="0"/>
                </xsl:if>
              
            </xsl:otherwise>
          </xsl:choose>

          <xsl:if test="($navigation_style = 'google') or
                      ($navigation_style = 'link')">
            <!-- *** Google result set navigation *** -->
            <xsl:variable name="mod_end">
              <xsl:choose>
                <xsl:when test="$next">
                  <xsl:value-of select="$guess"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$view_end"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>

            <xsl:call-template name="result_nav">
              <xsl:with-param name="start" select="0"/>
              <xsl:with-param name="end" select="$mod_end"/>
              <xsl:with-param name="current_view" select="($view_begin)-1"/>
              <xsl:with-param name="navigation_style" select="$navigation_style"/>
            </xsl:call-template>
          </xsl:if>

          <!-- *** Show next navigation, if available *** -->
          <xsl:choose>
            <xsl:when test="$next">
             
                <xsl:if test="$navigation_style != 'google'">
                  <xsl:call-template name="nbsp"/>
                </xsl:if>
                <span class="PageNavNext">
                  <a href="zoekresultaten.aspx?{$search_url}&amp;start={$view_begin +
                $num_results - 1}">
                    <xsl:if test="$navigation_style = 'google'">
                      <img src="/nav_next.gif" width="100" height="26" alt="Volgende" border="0"/>
                    </xsl:if>
                    <xsl:text>Volgende</xsl:text>
                    <xsl:if test="$navigation_style = 'top'">
                      <xsl:text>&gt;</xsl:text>
                    </xsl:if>
                  </a>
                </span>
             
            </xsl:when>
            <xsl:otherwise>
              
                <xsl:if test="$navigation_style != 'google'">
                  <xsl:call-template name="nbsp"/>
                </xsl:if>
                <xsl:if test="$navigation_style = 'google'">
                  <img src="/nav_last.gif" width="46" height="26"

									  alt="Last" border="0"/>
                </xsl:if>
            </xsl:otherwise>
          </xsl:choose>

          <!-- *** End Google result bar *** -->
        

      <xsl:if test="$navigation_style != 'top'">
        <xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <!-- **********************************************************************
	Utility functions for generating html entities
    *********************************************************************** -->
  <xsl:template name="nbsp">
    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
  </xsl:template>
  <xsl:template name="nbsp3">
    <xsl:call-template name="nbsp"/>
    <xsl:call-template name="nbsp"/>
    <xsl:call-template name="nbsp"/>
  </xsl:template>
  <xsl:template name="nbsp4">
    <xsl:call-template name="nbsp3"/>
    <xsl:call-template name="nbsp"/>
  </xsl:template>
  <xsl:template name="quot">
    <xsl:text disable-output-escaping="yes">&amp;quot;</xsl:text>
  </xsl:template>
  <xsl:template name="copy">
    <xsl:text disable-output-escaping="yes">&amp;copy;</xsl:text>
  </xsl:template>

  <!-- **********************************************************************
    Truncation functions (do not customize)
    *********************************************************************** -->
  <xsl:template name="truncate_url">
    <xsl:param name="t_url"/>

    <xsl:choose>
      <xsl:when test="string-length($t_url) &lt; $truncate_result_url_length">
        <xsl:value-of select="$t_url"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="first" select="substring-before($t_url, '/')"/>
        <xsl:variable name="last">
          <xsl:call-template name="truncate_find_last_token">
            <xsl:with-param name="t_url" select="$t_url"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="path_limit" select="$truncate_result_url_length - (string-length($first) + string-length($last) + 1)"/>

        <xsl:choose>
          <xsl:when test="$path_limit &lt;= 0">
            <xsl:value-of select="concat(substring($t_url, 1, $truncate_result_url_length), '...')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="chopped_path">
              <xsl:call-template name="truncate_chop_path">
                <xsl:with-param name="path" select="substring($t_url, string-length($first) + 2, string-length($t_url) - (string-length($first) + string-length($last) + 1))"/>
                <xsl:with-param name="path_limit" select="$path_limit"/>
              </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="concat($first, '/.../', $chopped_path, $last)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template name="truncate_find_last_token">
    <xsl:param name="t_url"/>

    <xsl:choose>
      <xsl:when test="contains($t_url, '/')">
        <xsl:call-template name="truncate_find_last_token">
          <xsl:with-param name="t_url" select="substring-after($t_url, '/')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$t_url"/>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template name="truncate_chop_path">
    <xsl:param name="path"/>
    <xsl:param name="path_limit"/>

    <xsl:choose>
      <xsl:when test="string-length($path) &lt;= $path_limit">
        <xsl:value-of select="$path"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="truncate_chop_path">
          <xsl:with-param name="path" select="substring-after($path, '/')"/>
          <xsl:with-param name="path_limit" select="$path_limit"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <!-- **********************************************************************
    Utility functions (do not customize)
    *********************************************************************** -->

  <!-- *** Find the substring after the last occurence of a separator *** -->
  <xsl:template name="last_substring_after">

    <xsl:param name="string"/>
    <xsl:param name="separator"/>
    <xsl:param name="fallback"/>

    <xsl:variable name="newString"
		  select="substring-after($string, $separator)"/>

    <xsl:choose>
      <xsl:when test="$newString!=''">
        <xsl:call-template name="last_substring_after">
          <xsl:with-param name="string" select="$newString"/>
          <xsl:with-param name="separator" select="$separator"/>
          <xsl:with-param name="fallback" select="$newString"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$fallback"/>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <!-- *** Find and replace *** -->
  <xsl:template name="replace_string">
    <xsl:param name="find"/>
    <xsl:param name="replace"/>
    <xsl:param name="string"/>
    <xsl:choose>
      <xsl:when test="contains($string, $find)">
        <xsl:value-of select="substring-before($string, $find)"/>
        <xsl:value-of select="$replace"/>
        <xsl:call-template name="replace_string">
          <xsl:with-param name="find" select="$find"/>
          <xsl:with-param name="replace" select="$replace"/>
          <xsl:with-param name="string"
					  select="substring-after($string, $find)"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$string"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>



  <!-- **********************************************************************
    Reformat the keyword match display in a title/snippet string (do not customize)
    ************************************************************************ -->
  <xsl:template name="reformat_keyword">
    <xsl:param name="orig_string"/>

    <!-- Replace <b>...</b> with <strong>...</strong> -->
    <xsl:variable name="reformatted_00">
      <xsl:call-template name="replace_string">
        <xsl:with-param name="find" select="'&lt;strong&gt;...&lt;/strong&gt;'"/>
        <xsl:with-param name="replace" select="'...'"/>
        <xsl:with-param name="string" select="$orig_string"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="reformatted_0">
      <xsl:call-template name="replace_string">
        <xsl:with-param name="find" select="'&lt;b&gt;...&lt;/b&gt;'"/>
        <xsl:with-param name="replace" select="'...'"/>
        <xsl:with-param name="string" select="$reformatted_00"/>
      </xsl:call-template>
    </xsl:variable>


    <!-- Remove breaks from snippets... -->
    <xsl:variable name="reformatted_1">
      <xsl:call-template name="replace_string">
        <xsl:with-param name="find" select="'&lt;br&gt;'"/>
        <xsl:with-param name="replace" select="' '"/>
        <xsl:with-param name="string" select="$reformatted_0"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="reformatted_2">
      <xsl:call-template name="replace_string">
        <xsl:with-param name="find" select="$keyword_orig_start"/>
        <xsl:with-param name="replace" select="$keyword_reformat_start"/>
        <xsl:with-param name="string" select="$reformatted_1"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="reformatted_3">
      <xsl:call-template name="replace_string">
        <xsl:with-param name="find" select="$keyword_orig_end"/>
        <xsl:with-param name="replace" select="$keyword_reformat_end"/>
        <xsl:with-param name="string" select="$reformatted_2"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of disable-output-escaping='yes' select="$reformatted_3"/>

  </xsl:template>

  <!-- **********************************************************************
 Empty result set (can be customized)
     ********************************************************************** -->
  <xsl:template name="no_RES">
    <xsl:param name="query"/>

    <span class="p">
      <br/>
      Uw zoekopdracht - <b>
        <xsl:value-of select="$query"/>
      </b> - heeft geen resultaten opgeleverd.
      <br/>
      Er zijn geen paginas gevonden met <b>
        &quot;<xsl:value-of select="$query"/>&quot;
      </b>.
      <br/>
      <br/>
      Suggesties:
      <ul>
        <li>Controleer of alle trefwoorden goed gespeld zijn.</li>
        <li>Probeer andere trefwoorden.</li>
        <li>Probeer meer algemene trefwoorden.</li>
      </ul>
    </span>

  </xsl:template>


</xsl:stylesheet>

