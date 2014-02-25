<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <title>
      main.c in sssp/trunk/src/plugin/codec/mp3/mpg123/mpglib
     – BugTracker
    </title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="search" href="https://oikw.org/bug/search">
        <link rel="help" href="https://oikw.org/bug/wiki/TracGuide">
        <link rel="alternate" href="https://oikw.org/bug/browser/sssp/trunk/src/plugin/codec/mp3/mpg123/mpglib/main.c?rev=531&amp;format=txt" type="text/plain" title="Plain Text"><link rel="alternate" href="https://oikw.org/bug/export/531/sssp/trunk/src/plugin/codec/mp3/mpg123/mpglib/main.c" type="text/x-csrc; charset=utf-8" title="Original Format">
        <link rel="up" href="https://oikw.org/bug/browser/sssp/trunk/src/plugin/codec/mp3/mpg123/mpglib/main.c">
        <link rel="next" href="https://oikw.org/bug/browser/sssp/trunk/src/plugin/codec/mp3/mpg123/mpglib/main.c?rev=535" title="Revision 535">
        <link rel="start" href="https://oikw.org/bug/wiki">
        <link rel="stylesheet" href="main_files/trac_002.css" type="text/css"><link rel="stylesheet" href="main_files/code.css" type="text/css"><link rel="stylesheet" href="main_files/trac.css" type="text/css"><link rel="stylesheet" href="main_files/browser.css" type="text/css">
        <link rel="shortcut icon" href="https://oikw.org/bug/chrome/common/trac.ico" type="image/x-icon">
        <link rel="icon" href="https://oikw.org/bug/chrome/common/trac.ico" type="image/x-icon">
      <link type="application/opensearchdescription+xml" rel="search" href="https://oikw.org/bug/search/opensearch" title="Search BugTracker">
    <script type="text/javascript" src="main_files/jquery.js"></script><script type="text/javascript" src="main_files/babel.js"></script><script type="text/javascript" src="main_files/trac.js"></script><script type="text/javascript" src="main_files/search.js"></script>
    <!--[if lt IE 7]>
    <script type="text/javascript" src="/chrome/js/ie_pre7_hacks.js"></script>
    <![endif]-->
    <script type="text/javascript" src="main_files/folding.js"></script>
    <script type="text/javascript">
      jQuery(document).ready(function($) {
        $(".trac-toggledeleted").show().click(function() {
                  $(this).siblings().find(".trac-deleted").toggle();
                  return false;
        }).click();
        $("#jumploc input").hide();
        $("#jumploc select").change(function () {
          this.parentNode.parentNode.submit();
        });
          $('#preview table.code').enableCollapsibleColumns($('#preview table.code thead th.content'));
      });
    </script>
  <script>try {  for(var lastpass_iter=0; lastpass_iter < document.forms.length; lastpass_iter++){    var lastpass_f = document.forms[lastpass_iter];    if(typeof(lastpass_f.lpsubmitorig)=="undefined"){      if (typeof(lastpass_f.submit) == "function") {        lastpass_f.lpsubmitorig = lastpass_f.submit;        lastpass_f.submit = function(){          var form = this;          try {            if (document.documentElement && 'createEvent' in document)            {              var forms = document.getElementsByTagName('form');              for (var i=0 ; i<forms.length ; ++i)                if (forms[i]==form)                {                  var element = document.createElement('lpformsubmitdataelement');                  element.setAttribute('formnum',i);                  element.setAttribute('from','submithook');                  document.documentElement.appendChild(element);                  var evt = document.createEvent('Events');                  evt.initEvent('lpformsubmit',true,false);                  element.dispatchEvent(evt);                  break;                }            }          } catch (e) {}          try {            form.lpsubmitorig();          } catch (e) {}        }      }    }  }} catch (e) {}</script></head>
  <body>
    <div id="banner">
      <div id="header">
        <h1><a href="">BugTracker</a></h1>
      </div>
      <form id="search" action="/bug/search" method="get">
        <div>
          <label for="proj-search">Search:</label>
          <input id="proj-search" name="q" size="18" type="text">
          <input value="Search" type="submit">
        </div>
      </form>
      <div id="metanav" class="nav">
    <ul>
      <li class="first"><a href="https://oikw.org/bug/login">Login</a></li><li><a href="https://oikw.org/bug/prefs">Preferences</a></li><li><a href="https://oikw.org/bug/wiki/TracGuide">Help/Guide</a></li><li><a href="https://oikw.org/bug/about">About Trac</a></li><li><a href="https://oikw.org/bug/register">Register</a></li><li class="last"><a href="https://oikw.org/bug/reset_password">Forgot your password?</a></li>
    </ul>
  </div>
    </div>
    <div id="mainnav" class="nav">
    <ul>
      <li class="first"><a href="https://oikw.org/bug/wiki">Wiki</a></li><li><a href="https://oikw.org/bug/timeline">Timeline</a></li><li><a href="https://oikw.org/bug/roadmap">Roadmap</a></li><li class="active"><a href="https://oikw.org/bug/browser">Browse Source</a></li><li><a href="https://oikw.org/bug/report">View Tickets</a></li><li class="last"><a href="https://oikw.org/bug/search">Search</a></li>
    </ul>
  </div>
    <div id="main">
      <div id="ctxtnav" class="nav">
        <h2>Context Navigation</h2>
          <ul>
              <li class="first"><span class="missing">← Previous Revision</span></li><li><a href="https://oikw.org/bug/browser/sssp/trunk/src/plugin/codec/mp3/mpg123/mpglib/main.c">Latest Revision</a></li><li><span><a class="next" href="https://oikw.org/bug/browser/sssp/trunk/src/plugin/codec/mp3/mpg123/mpglib/main.c?rev=535" title="Revision 535">Next Revision</a> →</span></li><li><a href="https://oikw.org/bug/browser/sssp/trunk/src/plugin/codec/mp3/mpg123/mpglib/main.c?annotate=blame&amp;rev=531" title="Annotate each line with the last changed revision (this can be time consuming...)">Annotate</a></li><li class="last"><a href="https://oikw.org/bug/log/sssp/trunk/src/plugin/codec/mp3/mpg123/mpglib/main.c?rev=531">Revision Log</a></li>
          </ul>
        <hr>
      </div>
    <div id="content" class="browser">
          <h1>
<a class="pathentry first" href="https://oikw.org/bug/browser?order=name" title="Go to repository root">source:</a>
<a class="pathentry" href="https://oikw.org/bug/browser/sssp?rev=531&amp;order=name" title="View sssp">sssp</a><span class="pathentry sep">/</span><a class="pathentry" href="https://oikw.org/bug/browser/sssp/trunk?rev=531&amp;order=name" title="View trunk">trunk</a><span class="pathentry sep">/</span><a class="pathentry" href="https://oikw.org/bug/browser/sssp/trunk/src?rev=531&amp;order=name" title="View src">src</a><span class="pathentry sep">/</span><a class="pathentry" href="https://oikw.org/bug/browser/sssp/trunk/src/plugin?rev=531&amp;order=name" title="View plugin">plugin</a><span class="pathentry sep">/</span><a class="pathentry" href="https://oikw.org/bug/browser/sssp/trunk/src/plugin/codec?rev=531&amp;order=name" title="View codec">codec</a><span class="pathentry sep">/</span><a class="pathentry" href="https://oikw.org/bug/browser/sssp/trunk/src/plugin/codec/mp3?rev=531&amp;order=name" title="View mp3">mp3</a><span class="pathentry sep">/</span><a class="pathentry" href="https://oikw.org/bug/browser/sssp/trunk/src/plugin/codec/mp3/mpg123?rev=531&amp;order=name" title="View mpg123">mpg123</a><span class="pathentry sep">/</span><a class="pathentry" href="https://oikw.org/bug/browser/sssp/trunk/src/plugin/codec/mp3/mpg123/mpglib?rev=531&amp;order=name" title="View mpglib">mpglib</a><span class="pathentry sep">/</span><a class="pathentry" href="https://oikw.org/bug/browser/sssp/trunk/src/plugin/codec/mp3/mpg123/mpglib/main.c?rev=531&amp;order=name" title="View main.c">main.c</a>
<span class="pathentry sep">@</span>
  <a class="pathentry" href="https://oikw.org/bug/changeset/531" title="View changeset 531">531</a>
<br style="clear: both">
</h1>
        <div id="jumprev">
          <form action="" method="get">
            <div>
              <label for="rev" title="Hint: clear the field to view latest revision">
                View revision:</label>
              <input id="rev" name="rev" value="531" size="6" type="text">
            </div>
          </form>
        </div>
      <table id="info" summary="Revision info">
        <tbody><tr>
          <th scope="col">Revision <a href="https://oikw.org/bug/changeset/531">531</a>,
            <span title="1230 bytes">1.2 KB</span>
            checked in by mocean, <a class="timeline" href="https://oikw.org/bug/timeline?from=2006-03-08T19%3A46%3A38%2B09%3A00&amp;precision=second" title="2006-03-08T19:46:38+09:00 in Timeline">7 years</a> ago
            (<a href="https://oikw.org/bug/changeset/531/sssp/trunk/src/plugin/codec/mp3/mpg123/mpglib/main.c">diff</a>)</th>
        </tr>
        <tr>
          <td class="message searchable">
          </td>
        </tr>
      </tbody></table>
      <div id="preview" class="searchable">
        
  <table class="code"><thead><tr><th style="cursor: pointer;" class="lineno" title="Line numbers (click to hide column)">Line</th><th class="content">&nbsp;</th></tr></thead><tbody><tr><th id="L1"><a href="#L1">1</a></th><td><span class="cm">/*</span></td></tr><tr><th id="L2"><a href="#L2">2</a></th><td><span class="cm">&nbsp; &nbsp;mpglib - Mpeg Audio Decoder Library</span></td></tr><tr><th id="L3"><a href="#L3">3</a></th><td><span class="cm">&nbsp; &nbsp;Copyright (C) 1995-2005&nbsp; The Mpg123 Project, All rights reserved.</span></td></tr><tr><th id="L4"><a href="#L4">4</a></th><td><span class="cm">&nbsp;</span></td></tr><tr><th id="L5"><a href="#L5">5</a></th><td><span class="cm">&nbsp; &nbsp; This library is free software; you can redistribute it and/or</span></td></tr><tr><th id="L6"><a href="#L6">6</a></th><td><span class="cm">&nbsp; &nbsp; modify it under the terms of the GNU Lesser General Public</span></td></tr><tr><th id="L7"><a href="#L7">7</a></th><td><span class="cm">&nbsp; &nbsp; License as published by the Free Software Foundation; either</span></td></tr><tr><th id="L8"><a href="#L8">8</a></th><td><span class="cm">&nbsp; &nbsp; version 2.1 of the License, or (at your option) any later version.</span></td></tr><tr><th id="L9"><a href="#L9">9</a></th><td><span class="cm">&nbsp;</span></td></tr><tr><th id="L10"><a href="#L10">10</a></th><td><span class="cm">&nbsp; &nbsp; This library is distributed in the hope that it will be useful,</span></td></tr><tr><th id="L11"><a href="#L11">11</a></th><td><span class="cm">&nbsp; &nbsp; but WITHOUT ANY WARRANTY; without even the implied warranty of</span></td></tr><tr><th id="L12"><a href="#L12">12</a></th><td><span class="cm">&nbsp; &nbsp; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.&nbsp; See the GNU</span></td></tr><tr><th id="L13"><a href="#L13">13</a></th><td><span class="cm">&nbsp; &nbsp; Lesser General Public License for more details.</span></td></tr><tr><th id="L14"><a href="#L14">14</a></th><td><span class="cm">&nbsp;</span></td></tr><tr><th id="L15"><a href="#L15">15</a></th><td><span class="cm">&nbsp; &nbsp; You should have received a copy of the GNU Lesser General Public</span></td></tr><tr><th id="L16"><a href="#L16">16</a></th><td><span class="cm">&nbsp; &nbsp; License along with this library; if not, write to the Free Software</span></td></tr><tr><th id="L17"><a href="#L17">17</a></th><td><span class="cm">&nbsp; &nbsp; Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA&nbsp; 02111-1307&nbsp; USA</span></td></tr><tr><th id="L18"><a href="#L18">18</a></th><td><span class="cm">*/</span></td></tr><tr><th id="L19"><a href="#L19">19</a></th><td><span class="cp"></span></td></tr><tr><th id="L20"><a href="#L20">20</a></th><td><span class="cp"></span></td></tr><tr><th id="L21"><a href="#L21">21</a></th><td><span class="cp">#include "mpg123.h"</span></td></tr><tr><th id="L22"><a href="#L22">22</a></th><td><span class="cp">#include "<span class="searchword1">mpglib.h</span>"</span></td></tr><tr><th id="L23"><a href="#L23">23</a></th><td><span class="cp"></span></td></tr><tr><th id="L24"><a href="#L24">24</a></th><td><span class="kt">char</span>&nbsp;buf<span class="p">[</span><span class="mi">16384</span><span class="p">];</span></td></tr><tr><th id="L25"><a href="#L25">25</a></th><td><span class="k">struct</span>&nbsp;mpstr mp<span class="p">;</span></td></tr><tr><th id="L26"><a href="#L26">26</a></th><td></td></tr><tr><th id="L27"><a href="#L27">27</a></th><td><span class="kt">void</span>&nbsp;<span class="nf">main</span><span class="p">(</span><span class="kt">void</span><span class="p">)</span></td></tr><tr><th id="L28"><a href="#L28">28</a></th><td><span class="p">{</span></td></tr><tr><th id="L29"><a href="#L29">29</a></th><td>&nbsp; &nbsp;<span class="kt">int</span>&nbsp;size<span class="p">;</span></td></tr><tr><th id="L30"><a href="#L30">30</a></th><td>&nbsp; &nbsp;<span class="kt">char</span>&nbsp;out<span class="p">[</span><span class="mi">8192</span><span class="p">];</span></td></tr><tr><th id="L31"><a href="#L31">31</a></th><td>&nbsp; &nbsp;<span class="kt">int</span>&nbsp;len<span class="p">,</span>ret<span class="p">;</span></td></tr><tr><th id="L32"><a href="#L32">32</a></th><td>&nbsp; &nbsp;</td></tr><tr><th id="L33"><a href="#L33">33</a></th><td></td></tr><tr><th id="L34"><a href="#L34">34</a></th><td>&nbsp; &nbsp;InitMP3<span class="p">(</span><span class="o">&amp;</span>mp<span class="p">);</span></td></tr><tr><th id="L35"><a href="#L35">35</a></th><td></td></tr><tr><th id="L36"><a href="#L36">36</a></th><td>&nbsp; &nbsp;<span class="k">while</span><span class="p">(</span><span class="mi">1</span><span class="p">)</span>&nbsp;<span class="p">{</span></td></tr><tr><th id="L37"><a href="#L37">37</a></th><td>&nbsp; &nbsp; &nbsp; len <span class="o">=</span>&nbsp;read<span class="p">(</span><span class="mi">0</span><span class="p">,</span>buf<span class="p">,</span><span class="mi">16384</span><span class="p">);</span></td></tr><tr><th id="L38"><a href="#L38">38</a></th><td>&nbsp; &nbsp; &nbsp; <span class="k">if</span><span class="p">(</span>len <span class="o">&lt;=</span>&nbsp;<span class="mi">0</span><span class="p">)</span></td></tr><tr><th id="L39"><a href="#L39">39</a></th><td>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span class="k">break</span><span class="p">;</span></td></tr><tr><th id="L40"><a href="#L40">40</a></th><td>&nbsp; &nbsp; &nbsp; ret <span class="o">=</span>&nbsp;decodeMP3<span class="p">(</span><span class="o">&amp;</span>mp<span class="p">,</span>buf<span class="p">,</span>len<span class="p">,</span>out<span class="p">,</span><span class="mi">8192</span><span class="p">,</span><span class="o">&amp;</span>size<span class="p">);</span></td></tr><tr><th id="L41"><a href="#L41">41</a></th><td>&nbsp; &nbsp; &nbsp; <span class="k">while</span><span class="p">(</span>ret <span class="o">==</span>&nbsp;MP3_OK<span class="p">)</span>&nbsp;<span class="p">{</span></td></tr><tr><th id="L42"><a href="#L42">42</a></th><td>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;write<span class="p">(</span><span class="mi">1</span><span class="p">,</span>out<span class="p">,</span>size<span class="p">);</span></td></tr><tr><th id="L43"><a href="#L43">43</a></th><td>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ret <span class="o">=</span>&nbsp;decodeMP3<span class="p">(</span><span class="o">&amp;</span>mp<span class="p">,</span><span class="nb">NULL</span><span class="p">,</span><span class="mi">0</span><span class="p">,</span>out<span class="p">,</span><span class="mi">8192</span><span class="p">,</span><span class="o">&amp;</span>size<span class="p">);</span></td></tr><tr><th id="L44"><a href="#L44">44</a></th><td>&nbsp; &nbsp; &nbsp; <span class="p">}</span></td></tr><tr><th id="L45"><a href="#L45">45</a></th><td>&nbsp; &nbsp;<span class="p">}</span></td></tr><tr><th id="L46"><a href="#L46">46</a></th><td></td></tr><tr><th id="L47"><a href="#L47">47</a></th><td><span class="p">}</span></td></tr><tr><th id="L48"><a href="#L48">48</a></th><td></td></tr></tbody></table>

      </div>
      <div id="help"><strong>Note:</strong> See <a href="https://oikw.org/bug/wiki/TracBrowser">TracBrowser</a>
        for help on using the repository browser.</div>
      <div id="anydiff">
        <form action="/bug/diff" method="get">
          <div class="buttons">
            <input name="new_path" value="/sssp/trunk/src/plugin/codec/mp3/mpg123/mpglib/main.c" type="hidden">
            <input name="old_path" value="/sssp/trunk/src/plugin/codec/mp3/mpg123/mpglib/main.c" type="hidden">
            <input name="new_rev" value="531" type="hidden">
            <input name="old_rev" value="531" type="hidden">
            <input value="View changes..." title="Select paths and revs for Diff" type="submit">
          </div>
        </form>
      </div>
    </div>
    <div id="altlinks">
      <h3>Download in other formats:</h3>
      <ul>
        <li class="first">
          <a rel="nofollow" href="https://oikw.org/bug/browser/sssp/trunk/src/plugin/codec/mp3/mpg123/mpglib/main.c?rev=531&amp;format=txt">Plain Text</a>
        </li><li class="last">
          <a rel="nofollow" href="https://oikw.org/bug/export/531/sssp/trunk/src/plugin/codec/mp3/mpg123/mpglib/main.c">Original Format</a>
        </li>
      </ul>
    </div>
    </div>
    <div id="footer" xml:lang="en" lang="en"><hr>
      <a id="tracpowered" href="http://trac.edgewall.org/"><img src="main_files/trac_logo_mini.png" alt="Trac Powered" height="30" width="107"></a>
      <p class="left">Powered by <a href="https://oikw.org/bug/about"><strong>Trac 0.12.2</strong></a><br>
        By <a href="http://www.edgewall.org/">Edgewall Software</a>.</p>
      <p class="right">Visit the Trac open source project at<br><a href="http://trac.edgewall.org/">http://trac.edgewall.org/</a></p>
    </div>
  
</body></html>