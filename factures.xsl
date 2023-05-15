<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
<xsl:variable name="filas" select="15"/>
    <xsl:template match="celler">
        <html>
            <head>
                <title>Celler</title>
                <link rel="stylesheet" href="estil.css"/>
            </head>
            <body>
                <div>
                    <xsl:apply-templates select="factures/factura"/>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="factura">
            <div class="pagina"><xsl:value-of select="@numero"/>
            <xsl:variable name="codi_client" select="comprador/@codi"/>
            <xsl:variable name="client" select="//client[@codi=$codi_client]"/>
        <div class="dades_client">
            <div><xsl:value-of select="$client/@codi"/></div>
            <div><xsl:value-of select="$client/nom"/></div>
        </div>
        <xsl:apply-templates select="unitats"/>
                <xsl:apply-templates select="vacias"/>
            </div>
    </xsl:template>

    <xsl:template match="unitats">

        <xsl:variable name="codi_producte" select="@codi"/>
        <xsl:variable name="producte" select="//producte[@codi=$codi_producte]"/>
            <div class="fila"><xsl:value-of select="$producte/@codi"/>
            <div><xsl:value-of select="$producte"/></div>
            <div><xsl:value-of select="."/></div>
            <div><xsl:value-of select="format-number($producte/@preu, '#.00€')"/></div>
            <div><xsl:value-of select="format-number(. * $producte/@preu, '#.00€')"/></div>
            </div>
    </xsl:template>
</xsl:stylesheet>