<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0" xmlns:calc="htt://example.com/calculator/types">

<xsl:output indent="yes" method="xml"/>

<xsl:template match="/">
<calc:splitResponse>
		<xsl:call-template name="output-tokens">
			<xsl:with-param name="list"><xsl:value-of select="/calc:splitRequest/value" /></xsl:with-param>
		</xsl:call-template>
</calc:splitResponse>
</xsl:template>

<xsl:template name="output-tokens">
    <xsl:param name="list" />
    <xsl:variable name="newlist" select="concat(normalize-space($list), ' ')" />
    <xsl:variable name="first" select="substring-before($newlist, ' ')" />
    <xsl:variable name="remaining" select="substring-after($newlist, ' ')" />
    <value><xsl:value-of select="$first" /></value>
    <xsl:if test="$remaining">
        <xsl:call-template name="output-tokens">
            <xsl:with-param name="list" select="$remaining" />
        </xsl:call-template>
    </xsl:if>
</xsl:template>
</xsl:stylesheet>


