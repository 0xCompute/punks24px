# Hamilton (Franklin) Book Theme by Bryan Braun

See a live version @ [`bookdesigns.github.io/book-hamilton` »](http://bookdesigns.github.io/book-hamilton)


## Update & Build Notes


### Changes

- Removed Happy Browsing Banner
- Removed Internet Explorer (IE) Conditionals



### Syntax Highlighting

Generate syntax.css theme using Rouge

```
<%# A good day theme, though not that colorful %>
<%#= Rouge::Themes::Github.render(:scope => '.highlight') %>

<%# A good day theme, and is very colorful %>
<%= Rouge::Themes::Base16.render(:scope => '.highlight') %>

<%# That good sublime text night theme%>
<%#= Rouge::Themes::Base16::Monokai.render(:scope => '.highlight') %>
```



