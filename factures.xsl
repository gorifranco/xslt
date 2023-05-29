<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <xsl:key name="client" match="client" use="@codi"/>
    <xsl:key name="producte" match="producte" use="@codi"/>

    <xsl:template match="celler">
        <html>
            <head>
                <title>Ca'n Franco</title>
                <link rel="stylesheet" href="estil.css"/>
            </head>
            <body>
                <div>
                    <xsl:apply-templates select="factures/factura"/>
                </div>
                <script>
                    document.getElementById("data").innerHTML = Date();
                </script>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="factura">

        <div class="pagina">
            <div class="top1">
                <div class="logo"><img src="logo.svg" alt="logo"/></div>
                <div class="titol">Ca'n Franco</div>
            </div>
<div class="dades">
            <div class="dades_empresa">
                <div class="camp">Codi factura:</div><div><xsl:value-of select="@numero"/></div>
                <div class="camp"> Data:<div class="data"> </div></div>
                <div class="camp">NIF empresa:</div><div>D54877669</div>
            </div>
            <div class="dadesClient">
                <xsl:variable name="codi_client" select="comprador/@codi"/>
                <xsl:variable name="client" select="//client[@codi=$codi_client]"/>
                <div class="camp">Codi client: </div><div><xsl:value-of select="$client/@codi"/></div>
                    <div class="camp" >Nom client: </div><div><xsl:value-of select="$client/nom"/></div>
                    <div class="camp">Telefon contacte 1: </div><div><xsl:value-of select="$client/telefon[1]"/></div>
                <div class="camp">Telefon contacte 2: </div><div><xsl:value-of select="$client/telefon[2]"/></div>
            </div>
</div>
            <div class="compra">
                <div class="fila camps">
                    <div class="codi">Codi</div>
                    <div class="unitats">Unitats</div>
                    <div class="producte">Producte</div>
                    <div class="preu">Preu</div>
                    <div class="import">Import</div>
                </div>
                <xsl:call-template name="compra">
                    <xsl:with-param name="contador" select="1"/>
                </xsl:call-template>
            </div>
            <xsl:variable name="total">
                <xsl:for-each select="unitats">

                    <xsl:variable name="codi_producte" select="@codi"/>

                    <xsl:variable name="producte" select="//producte[@codi=$codi_producte]"/>
                    <xsl:element name="parcial">
                        <xsl:value-of select=". * $producte/@preu"/>
                    </xsl:element>
                </xsl:for-each>
            </xsl:variable>
            <div class="fila total">
            <div>Total</div>
                <div><xsl:value-of select="format-number(sum($total/parcial), '#.00€')"/> </div>
            </div>

            <xsl:variable name="codi_client" select="comprador/@codi"/>
            <xsl:variable name="client" select="//client[@codi=$codi_client]"/>
            <div class="firma"><p class="orientacio"><xsl:value-of select="substring(substring-after($client/nom, ','), 2, 1), '.', substring-before($client/nom, ' ')"/></p> </div>

        </div>
    </xsl:template>

    <xsl:template name="compra">
        <xsl:param name="contador"/>

        <xsl:choose>
            <xsl:when test="unitats[$contador]">
                <xsl:variable name="codi_producte" select="unitats[$contador]/@codi"/>
                <xsl:variable name="producte" select="key('producte', $codi_producte)"/>
                <xsl:variable name="preu" select="$producte/@preu"/>

                <div class="fila">
                    <div><xsl:value-of select="$codi_producte"/></div>
                    <div><xsl:value-of select="unitats[$contador]"/></div>
                    <div><xsl:value-of select="$producte"/></div>
                    <div><xsl:value-of select="format-number($preu, '#.00€')"/></div>
                    <div><xsl:value-of select="format-number($preu * unitats[$contador], '#.00€')"/></div>
                </div>

            </xsl:when>
            <xsl:otherwise>
                <div class="fila">
                    <div> </div>
                    <div> </div>
                    <div> </div>
                    <div> </div>
                    <div> </div>
                </div>
            </xsl:otherwise>
        </xsl:choose>

        <xsl:if test="not($contador = 13)">
            <xsl:call-template name="compra">
                <xsl:with-param name="contador" select="1 + $contador"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>