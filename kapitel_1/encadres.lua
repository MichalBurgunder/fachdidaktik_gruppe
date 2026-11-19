-- Convert Markdown exercise and solution blocks to LaTeX environments.
function Div(el)
  if not FORMAT:match('latex') then
    return nil
  end
  for _, class in ipairs({'exercice', 'solution'}) do
    if el.classes:includes(class) then
      local blocks = pandoc.List()
      blocks:insert(pandoc.RawBlock('latex', '\\begin{' .. class .. '}'))
      blocks:extend(el.content)
      blocks:insert(pandoc.RawBlock('latex', '\\end{' .. class .. '}'))
      return blocks
    end
  end
end
-- Give Markdown tables a visible border around every cell in PDF exports.
function Table(tbl)
  if not FORMAT:match('latex') then return nil end

  local count = #tbl.colspecs
  local columns = {}
  for i, spec in ipairs(tbl.colspecs) do
    local align = ({AlignLeft='\\raggedright', AlignCenter='\\centering',
                    AlignRight='\\raggedleft'})[tostring(spec[1])] or '\\raggedright'
    local width = spec[2]
    if not width or width == 0 then width = 1 / count end
    columns[i] = '>{' .. align .. '\\arraybackslash}p{\\dimexpr '
      .. string.format('%.6f', width) .. '\\linewidth-2\\tabcolsep-'
      .. string.format('%.6f', (count + 1) / count) .. '\\arrayrulewidth\\relax}'
  end

  local output = {'\\begingroup', '\\renewcommand{\\arraystretch}{1.5}',
    '\\begin{longtable}{|' .. table.concat(columns, '|') .. '|}', '\\hline'}

  local function rows(items)
    for _, row in ipairs(items) do
      local cells = {}
      for _, cell in ipairs(row.cells) do
        local content = pandoc.write(pandoc.Pandoc(cell.contents), 'latex')
        content = content:gsub('%s+$', '')
        cells[#cells + 1] = '\\strut ' .. content
      end
      output[#output + 1] = table.concat(cells, ' & ') .. ' \\\\ \\hline'
    end
  end

  rows(tbl.head.rows)
  for _, body in ipairs(tbl.bodies) do
    rows(body.head)
    rows(body.body)
  end
  rows(tbl.foot.rows)
  output[#output + 1] = '\\end{longtable}'
  output[#output + 1] = '\\endgroup'
  return pandoc.RawBlock('latex', table.concat(output, '\n'))
end

-- Raw LaTeX tables require these packages even after Table nodes are replaced.
function Meta(meta)
  if not FORMAT:match('latex') then return meta end
  local includes = meta['header-includes'] or pandoc.MetaList({})
  if includes.t ~= 'MetaList' and type(includes) ~= 'table' then
    includes = pandoc.MetaList({includes})
  end
  includes[#includes + 1] = pandoc.MetaBlocks({
    pandoc.RawBlock('latex', [[
\usepackage{array,longtable}
\AtBeginDocument{\setlength{\parskip}{0.8em}\setlength{\parindent}{0pt}}
\usepackage[most]{tcolorbox}
\tcbset{before skip=12pt,after skip=12pt,left=10pt,right=10pt,top=8pt,bottom=8pt,before upper={\setlength{\parskip}{0.8em}}}
\newtcolorbox{exercice}{colback=blue!5,colframe=blue!50!black,breakable}
\newtcolorbox{solution}{colback=green!5,colframe=green!50!black,breakable}
]])
  })
  meta['header-includes'] = includes
  return meta
end
