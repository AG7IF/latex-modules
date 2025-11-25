\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cap-fileplan}

\DeclareOption{draft}{%
    \newcommand{\@draft}{}
}

\ProcessOptions\relax

\LoadClass[12pt]{article}

\RequirePackage{booktabs}
\RequirePackage{fancyhdr}
\RequirePackage[
    top=1.0in,
    bottom=0.75in,
    left=0.25in,
    right=0.25in,
    headheight=15pt
]{geometry}
\RequirePackage{lastpage}
\RequirePackage{xltabular}

\ifdefined\@draft
    \RequirePackage{draftwatermark}
\fi

\newcommand{\review}[1]{%
    \def\@review{#1}
}

\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\ifdefined\@draft
    \fancyhead[L]{Date Prepared: DRAFT}
\else
    \fancyhead[L]{Date Prepared: \@date}
\fi
\fancyhead[C]{\@title}
\ifdefined\@draft
    \fancyhead[R]{Next Review: DRAFT}
\else
    \fancyhead[R]{Next Review: \@review}
\fi

\fancyfoot[L]{Prepared by: \@author}
\fancyfoot[R]{Page\ \thepage\ of\ \pageref{LastPage}}
\pagestyle{fancy}

\setlength{\parindent}{0pt}

