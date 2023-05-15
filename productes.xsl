<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <xsl:template match="celler">
        <html>
            <head>
                <title>Celler</title>
                <link rel="stylesheet" href="estil.css"/>
            </head>
            <body>
                <xsl:apply-templates select="productes"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="productes">
        <table>
            <xsl:apply-templates select="producte"/>
        </table>
    </xsl:template>

    <xsl:template match="producte">
        <tr>
            <td><xsl:value-of select="@codi"/></td>
            <td><xsl:value-of select="current()"/></td>
            <td><xsl:value-of select="@preu"/></td>
        </tr>
    </xsl:template>

</xsl:stylesheet>