\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ag7if-journal}

\DeclareOption{draft}{%
    \newcommand{\@draft}{}
}

\ProcessOptions\relax

\LoadClass[12pt]{article}

\RequirePackage[hidelinks]{hyperref}
\RequirePackage{booktabs}
\RequirePackage{cleveref}
\RequirePackage[
    margin=1in,
    headheight=15pt,
    footskip=0.5in
]{geometry}
\RequirePackage{graphicx}
\RequirePackage{tabularx}
\RequirePackage{usaf-pub}

\ifdefined\@draft
    \RequirePackage{draftwatermark}
\fi

\pagestyle{usaf}

% Titlepage Setup
\newcommand{\volume}[1]{\def\@volume{#1}}
\newcommand{\issue}[1]{\def\@issue{#1}}
\newcommand{\society}[1]{\def\@society{#1}}
\newcommand{\journal}[2][Journal of]{\def\@journal{#1~#2}}
\newcommand{\coverSeal}[1]{\def\@coverSeal{#1}}
\newcommand{\timePeriod}[1]{\def\@timePeriod{#1}}

\renewcommand{\maketitle}{%
    \thispagestyle{plain}
    \begin{center}
        \begin{tabularx}{\textwidth}{Xlrlrr}
        \toprule
            \@society & Volume & \@volume & Number & \@issue & \@date \\
        \bottomrule
        \end{tabularx}

        \vspace{1in}

        \huge
        \@journal%
     
        \vfill

        \LARGE

        Proceedings for~\@timePeriod%

        \vspace{1in}

        \includegraphics[height=4in]{\@coverSeal}

        \vfill

    \end{center}

    \cleardoublepage   
    
    \tableofcontents
    
    \cleardoublepage
}

% Define commands from usaf-memo and usaf-paper as NOOP for standalone operation
%% Common
\newcommand{\controlNumber}[1]{}

%% usaf-memo
\newcommand{\memofrom}[1]{}
\newcommand{\subject}[1]{}

%% usaf-paper
\renewcommand{\title}[2][]{\def\@title{#2}}
\newcommand{\authorOffice}[1]{}
\newcommand{\authorContact}[1]{}
\newcommand{\typist}[1]{}

