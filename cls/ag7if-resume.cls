\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ag7if-resume}

\LoadClass{curve}


\RequirePackage[colorlinks=true,allcolors=black,breaklinks=true]{hyperref}
\def\description{} % Hack to import enumitem AND let it redefine itemize on import
\RequirePackage[inline]{enumitem}
\RequirePackage[fixed]{fontawesome5}
\RequirePackage[nohead,nofoot,hmargin=1in,vmargin=0.5in]{geometry}
\RequirePackage{relsize}
\RequirePackage{tabularx}
\RequirePackage{tikz}
\RequirePackage[dvipsnames,svgnames]{xcolor}
\RequirePackage{xpatch}

\definecolor{Primary}{HTML}{0B0049}
\definecolor{Secondary}{HTML}{801300}

% Header Setup
\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\tagLine}[1]{\def\@tagLine{#1}}

\def\@contacts{}

\newcommand{\contactEntry}[2]{%
    \g@addto@macro\@contacts{#1 & #2 \\}
}

\newcommand{\contact}[2]{%
    \contactEntry{\color{Secondary!80!black}#1}{\texttt{#2}}%
}

\newcommand{\contactURL}[3]{%
    \contactEntry{\color{Secondary!80!black}#1}{\href{#2}{\texttt{#3}}}%
}

\leftheader{%
    {\LARGE\bfseries\sffamily \@name}

    \vspace{0.5em}

    {\large\bfseries\sffamily \@tagLine}
}

\rightheader{%
    \begin{tabularx}{.3\textwidth}{cl}
        \@contacts
    \end{tabularx}
}

% Rubric Configuration
\setlist[itemize]{nosep}

\newcommand*\circled[1]{\tikz[baseline=(char.base)]{
   \node[shape=circle,text=white,fill=Secondary!80!black,font=\sffamily\scriptsize\bfseries,inner sep=1pt,text height=1.35ex,minimum width=1.5em,text centered] (char) {#1};}}
   
\xpretofieldformat{doi}
  {\textcolor{Secondary!80!black}{\scriptsize\faLink}}
  {}{}
\xpretofieldformat{url}
  {\textcolor{Secondary!80!black}{\scriptsize\faLink}}
  {}{}

%\headerscale{1}
%\setlength{\headerspace}{6pt}
\rubricfont{\Large\bfseries\sffamily}
\setlength{\rubricspace}{2pt}
%\setlength{\rubricafterspace}{-9pt}
\setlength{\rubricafterspace}{-3pt}
\setlength{\subrubricspace}{3pt}
\setlength{\subrubricbeforespace}{4pt}
\def\@@rubrichead#1{%
  \begin{tikzpicture}[baseline]%\
  \shade[left color=Primary!60!white, right color=white] rectangle (\@almosttextwidth,2.5pt);
  \node[font={\@rubricfont},inner sep=0pt,text ragged,anchor=south west,text depth=.5ex,text height=1.5ex] at (1pt,2pt) {#1};
  \end{tikzpicture}%
  \vspace\rubricspace%
}

\subrubricfont{\large\bfseries\sffamily}
\subrubricalignment{l}

\newcommand{\makefield}[2]{\makebox[1.5em]{\color{Secondary!80!black}#1} #2\hspace{2em}}

\keyalignment{r}
\rubricalignment{l}
\renewcommand{\arraystretch}{1.25}
\urlstyle{tt}

\newcommand{\prefixmarker}[1]{\def\@prefixmarker{#1}}
\def\@prefixmarker{\relscale{.9}\faBookmark}

\prefix{%
  \hspace*{-1ex}
  \color{Secondary!80!black}\@prefixmarker%
  \hspace*{1ex}%
}

\newcommand{\makerubrichead}[1]{\vskip\baselineskip\@@rubrichead{#1}}

