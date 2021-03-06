<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- 
  Converts quotation marks to &#182; (paragraph mark).
  Pipe through sed to get quotation marks escaped for
  Excel: sed 's/\xB6/""/g'.
-->

<xsl:output method="text" encoding="iso-8859-1"/>

<xsl:strip-space elements="*"/>

<xsl:template match="/">
  <xsl:text>+, Pt-EMPI, Case-AccessionNumber, Case-AccessionDate, Case-SignoutDate, Part-CollectionDate, Part-Designator, Part-Type, Part-TypeDisp, Part-Descr, SR-Name, SR-NameDisp, SR-Version, Item-Number, Item-Name, Item-NameDisp, Value-Name, Value-NameDisp, Value-FreeText, Value-SNOMEDConceptId&#xa;</xsl:text>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="/CoPathDump/Patient/Case/CasePart">
  <xsl:for-each select=".">
    <xsl:text>+</xsl:text>
    <xsl:text>,</xsl:text><xsl:value-of select="../../@empi"/>
    <xsl:text>,</xsl:text><xsl:value-of select="../@accessionNumber"/>
    <xsl:text>,</xsl:text><xsl:value-of select="../@accessionDate"/>
    <xsl:text>,</xsl:text><xsl:value-of select="../@signoutDate"/>
    <xsl:text>,</xsl:text><xsl:value-of select="@collectionDate"/>
    <xsl:text>,</xsl:text><xsl:value-of select="@designator"/>
    <xsl:text>,</xsl:text><xsl:value-of select="@partType"/>
    <xsl:text>,"</xsl:text><xsl:value-of select="translate(@partTypeDisp, '&quot;', '&#182;')"/><xsl:text>"</xsl:text>
    <xsl:text>,"</xsl:text><xsl:value-of select="translate(@description, '&quot;', '&#182;')"/><xsl:text>"</xsl:text>
    <xsl:if test="not(CasePartSynopticReport)">
      <xsl:text>&#xa;</xsl:text>
    </xsl:if>
    <xsl:for-each select="CasePartSynopticReport/CPSRItem/CPSRItemValue">
      <xsl:if test="position() > 1">
        <xsl:text>+</xsl:text>
        <xsl:text>,</xsl:text><xsl:value-of select="../../../../../@empi"/>
        <xsl:text>,</xsl:text><xsl:value-of select="../../../../@accessionNumber"/>
        <xsl:text>,</xsl:text><xsl:value-of select="../../../../@accessionDate"/>
        <xsl:text>,</xsl:text><xsl:value-of select="../../../../@signoutDate"/>
        <xsl:text>,</xsl:text><xsl:value-of select="../../../@collectionDate"/>
        <xsl:text>,</xsl:text><xsl:value-of select="../../../@designator"/>
        <xsl:text>,</xsl:text><xsl:value-of select="../../../@partType"/>
        <xsl:text>,"</xsl:text><xsl:value-of select="translate(../../../@partTypeDisp, '&quot;', '&#182;')"/><xsl:text>"</xsl:text>
        <xsl:text>,"</xsl:text><xsl:value-of select="translate(../../../@description, '&quot;', '&#182;')"/><xsl:text>"</xsl:text>
      </xsl:if>
      <xsl:text>,</xsl:text><xsl:value-of select="../../@srName"/>
      <xsl:text>,"</xsl:text><xsl:value-of select="translate(../../@srNameDisp, '&quot;', '&#182;')"/><xsl:text>"</xsl:text>
      <xsl:text>,</xsl:text><xsl:value-of select="../../@srVersion"/>
      <xsl:text>,</xsl:text><xsl:value-of select="../@number"/>
      <xsl:text>,</xsl:text><xsl:value-of select="../@itemName"/>
      <xsl:text>,"</xsl:text><xsl:value-of select="translate(../@itemNameDisp, '&quot;', '&#182;')"/><xsl:text>"</xsl:text>
      <xsl:text>,</xsl:text><xsl:value-of select="@valName"/>
      <xsl:text>,"</xsl:text><xsl:value-of select="translate(@valNameDisp, '&quot;', '&#182;')"/><xsl:text>"</xsl:text>
      <xsl:text>,"</xsl:text><xsl:value-of select="translate(., '&quot;', '&#182;')"/><xsl:text>"</xsl:text>
      <xsl:text>,</xsl:text><xsl:value-of select="@snomedConceptId"/>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
  </xsl:for-each>
</xsl:template>

<xsl:template match="/CoPathDump/Patient/Case/CaseFinalText">
</xsl:template>

</xsl:stylesheet>
