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
                <div>
                    <xsl:apply-templates select="factures/factura"/>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="factura">
        <div class="pagina">
            <xsl:value-of select="@numero"/>
            <xsl:variable name="codi_client" select="comprador/@codi"/>
            <xsl:variable name="client" select="//client[@codi=$codi_client]"/>
            <div class="dades_client">
                <div>
                    <xsl:value-of select="$client/@codi"/>
                </div>
                <div>
                    <xsl:value-of select="$client/nom"/>
                </div>
            </div>
            <xsl:call-template name="compra">
                <xsl:with-param name="contador" select="1"/>
            </xsl:call-template>
            <xsl:variable name="total">
                <xsl:for-each select="unitats">
                    <xsl:variable name="codi_producte" select="@codi"/>
                    <xsl:variable name="producte" select="//producte[@codi=$codi_producte]"/>
                    <xsl:element name="parcial">
                        <xsl:value-of select="current() * $producte/@preu"/>
                    </xsl:element>
                </xsl:for-each>
            </xsl:variable>
        <div class="total"><xsl:value-of select="format-number(sum($total/parcial), '#.00€')"/></div>
        </div>
    </xsl:template>
    <xsl:template name="compra">
        <xsl:param name="contador"/>
        <xsl:choose>
            <xsl:when test="unitats[$contador]">
                <xsl:variable name="codi_producte" select="unitats[$contador]/@codi"/>
                <xsl:variable name="producte" select="//producte[@codi=$codi_producte]"/>
                <xsl:variable name="preu" select="$producte/@preu"/>
                <xsl:variable name="subtotal" select="$preu * unitats[$contador]"/>
                <div class="fila">
                    <div class="dada">
                        <xsl:value-of select="$codi_producte"/>
                    </div>
                    <div class="dada">
                        <xsl:value-of select="unitats[$contador]"/>
                    </div>
                    <div class="dada">
                        <xsl:value-of select="$producte"/>
                    </div>
                    <div class="dada">
                        <xsl:value-of select="format-number($preu, '#.00€')"/>
                    </div>
                    <div class="dada">
                        <xsl:value-of select="format-number($subtotal, '#.00€')"/>
                    </div>
                </div>
                <xsl:call-template name="compra">
                    <xsl:with-param name="contador" select="1+$contador"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="13 > $contador">
                    <div class="fila">
                    <div class="dada"> </div>
                    <div class="dada"> </div>
                    <div class="dada"> </div>
                    <div class="dada"> </div>
                    <div class="dada"> </div>
                    </div>
                    <xsl:call-template name="compra">
                        <xsl:with-param name="contador" select="1 + $contador"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>