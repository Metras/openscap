<?xml version="1.0" encoding="UTF-8"?>

<!--
Copyright 2012 Red Hat Inc., Durham, North Carolina.
All Rights Reserved.

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA

Authors:
      Šimon Lukašík
-->

<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xccdf_11="http://checklists.nist.gov/xccdf/1.1"
  version="1.0">
  <xsl:output method="xml" indent="yes"/>

  <xsl:key name="values" match="//xccdf_11:Value" use="@id"/>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="xccdf_11:sub">
    <xsl:variable name="idref" select="@idref"/>
    <xsl:choose>
      <xsl:when test="key('values', $idref)">
        <xsl:element name="{local-name()}" namespace="{namespace-uri()}">
          <xsl:apply-templates select="@*"/>
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>UNDEFINED_SUB</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>

