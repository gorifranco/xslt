<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

    <xsl:template match="celler">
        <xsl:apply-templates select="clients"/>
    </xsl:template>

    <xsl:template match="clients">
        <clients>
            <xsl:apply-templates select="client">
                <!--<xsl:sort select="nom"/>-->
            </xsl:apply-templates>
        </clients>
    </xsl:template>

    <xsl:template match="client">
        <client>
            <codi><xsl:value-of select="@codi"/></codi>
            <nom><xsl:value-of select="nom"/></nom>
<!--
            <telefon><xsl:value-of select="telefon[1]"/></telefon>
            <xsl:choose>
                <xsl:when test="count(telefon) > 1">
                    <telefon><xsl:value-of select="telefon[2]"/></telefon>
                </xsl:when>
            </xsl:choose>
-->
            <xsl:for-each select="telefon">
                <telefon><xsl:value-of select="current()"/></telefon>
            </xsl:for-each>
        </client>
    </xsl:template>

</xsl:stylesheet>