<?xml version="1.0"?>
<!--
   Purpose:
     Copy all nodes

   Input:
     DocBook 5 document

   Parameters:
     - filename
       The absolute path of the XML input file

   Output:
     DocBook 5 document with DOCTYPE declaration for 4.5

   Author:    Thomas Schraitle <toms@opensuse.org>
   Copyright (C) 2015 SUSE Linux GmbH

-->
<xsl:stylesheet version="1.0"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../common/copy.xsl"/>
<xsl:import href="xinclude-parse-text.xsl"/>

<xsl:param name="filename"/>

  <!-- Rewrite only xi:include elements which contains parse='text' attribute.
       DAPS handles that and copies all relevant files
  -->
  <xsl:template match="xi:include[@parse='text']">
    <xsl:call-template name="xinclude-text"/>
  </xsl:template>

  <!-- Add xml:base attribute in the output root element when there is no
       xml:base attribute in the input XML
  -->
  <xsl:template match="/*[not(@xml:base)]">
    <xsl:copy>
      <xsl:attribute name="xml:base">
        <xsl:value-of select="$filename"/>
      </xsl:attribute>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>

