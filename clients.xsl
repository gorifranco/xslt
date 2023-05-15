<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <xsl:template match="celler">
        <html>
            <head>
                <title>Celler</title>
                <link rel="stylesheet" href="estil.css"/>
            </head>
            <body>
                <xsl:apply-templates select="clients"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="clients">
        <table>
            <xsl:apply-templates select="client">
                <xsl:sort select="nom"/>
            </xsl:apply-templates>
        </table>
    </xsl:template>

    <xsl:template match="client">
        <tr>
            <td><xsl:value-of select="@codi"/></td>
            <td><xsl:value-of select="nom"/></td>
            <td><xsl:value-of select="telefon[1]"/></td>
            <td><xsl:value-of select="telefon[2]"/></td>
        </tr>
    </xsl:template>

</xsl:stylesheet>