// Populate the sidebar
//
// This is a script, and not included directly in the page, to control the total size of the book.
// The TOC contains an entry for each page, so if each page includes a copy of the TOC,
// the total size of the page becomes O(n**2).
class MDBookSidebarScrollbox extends HTMLElement {
    constructor() {
        super();
    }
    connectedCallback() {
        this.innerHTML = '<ol class="chapter"><li class="chapter-item expanded affix "><a href="title-page.html">Ruchy REPL &amp; One-Liner Demos</a></li><li class="chapter-item expanded affix "><a href="introduction.html">Introduction</a></li><li class="chapter-item expanded affix "><li class="spacer"></li><li class="chapter-item expanded "><a href="ch01-00-basics-tdd.html"><strong aria-hidden="true">1.</strong> Chapter 1: Basics</a><a class="toggle"><div>❱</div></a></li><li><ol class="section"><li class="chapter-item "><a href="ch01-01-arithmetic.html"><strong aria-hidden="true">1.1.</strong> Arithmetic Operations</a></li><li class="chapter-item "><a href="ch01-02-variables.html"><strong aria-hidden="true">1.2.</strong> Variables and Assignment</a></li><li class="chapter-item "><a href="ch01-03-strings.html"><strong aria-hidden="true">1.3.</strong> String Manipulation</a></li><li class="chapter-item "><a href="ch01-04-booleans.html"><strong aria-hidden="true">1.4.</strong> Boolean Logic</a></li><li class="chapter-item "><a href="ch01-05-arrays.html"><strong aria-hidden="true">1.5.</strong> Arrays and Collections</a></li></ol></li><li class="chapter-item expanded "><a href="ch02-00-functions-tdd.html"><strong aria-hidden="true">2.</strong> Chapter 2: Functions</a><a class="toggle"><div>❱</div></a></li><li><ol class="section"><li class="chapter-item "><a href="ch02-01-basic-functions.html"><strong aria-hidden="true">2.1.</strong> Basic Function Definition</a></li><li class="chapter-item "><a href="ch02-02-recursion.html"><strong aria-hidden="true">2.2.</strong> Recursion Patterns</a></li><li class="chapter-item "><a href="ch02-03-closures.html"><strong aria-hidden="true">2.3.</strong> Closures and Scope</a></li><li class="chapter-item "><a href="ch02-04-higher-order.html"><strong aria-hidden="true">2.4.</strong> Higher-Order Functions</a></li><li class="chapter-item "><a href="ch02-05-composition.html"><strong aria-hidden="true">2.5.</strong> Function Composition</a></li></ol></li><li class="chapter-item expanded "><a href="ch03-00-data-structures-tdd.html"><strong aria-hidden="true">3.</strong> Chapter 3: Data Structures</a><a class="toggle"><div>❱</div></a></li><li><ol class="section"><li class="chapter-item "><a href="ch03-01-arrays-vectors.html"><strong aria-hidden="true">3.1.</strong> Arrays and Vectors</a></li><li class="chapter-item "><a href="ch03-02-hashmaps-structs.html"><strong aria-hidden="true">3.2.</strong> HashMaps and Structs</a></li><li class="chapter-item "><a href="ch03-03-advanced-collections.html"><strong aria-hidden="true">3.3.</strong> Advanced Collections</a></li><li class="chapter-item "><a href="ch03-04-tree-graph.html"><strong aria-hidden="true">3.4.</strong> Tree and Graph Structures</a></li></ol></li><li class="chapter-item expanded "><a href="ch04-00-algorithms-tdd.html"><strong aria-hidden="true">4.</strong> Chapter 4: Algorithms</a><a class="toggle"><div>❱</div></a></li><li><ol class="section"><li class="chapter-item "><a href="ch04-01-sorting.html"><strong aria-hidden="true">4.1.</strong> Sorting Algorithms</a></li><li class="chapter-item "><a href="ch04-02-searching.html"><strong aria-hidden="true">4.2.</strong> Search Algorithms</a></li><li class="chapter-item "><a href="ch04-03-graphs.html"><strong aria-hidden="true">4.3.</strong> Graph Algorithms</a></li><li class="chapter-item "><a href="ch04-04-dynamic-programming.html"><strong aria-hidden="true">4.4.</strong> Dynamic Programming</a></li></ol></li><li class="chapter-item expanded "><a href="ch05-00-functional-tdd.html"><strong aria-hidden="true">5.</strong> Chapter 5: Functional Programming</a><a class="toggle"><div>❱</div></a></li><li><ol class="section"><li class="chapter-item "><a href="ch05-01-map-filter-reduce.html"><strong aria-hidden="true">5.1.</strong> Map, Filter, Reduce</a></li><li class="chapter-item "><a href="ch05-02-pipelines.html"><strong aria-hidden="true">5.2.</strong> Pipeline Operations</a></li><li class="chapter-item "><a href="ch05-03-advanced-functional.html"><strong aria-hidden="true">5.3.</strong> Advanced Functional Patterns</a></li></ol></li><li class="chapter-item expanded "><a href="ch06-00-advanced-tdd.html"><strong aria-hidden="true">6.</strong> Chapter 6: Advanced Features</a><a class="toggle"><div>❱</div></a></li><li><ol class="section"><li class="chapter-item "><a href="ch06-01-pattern-matching.html"><strong aria-hidden="true">6.1.</strong> Pattern Matching</a></li><li class="chapter-item "><a href="ch06-02-error-handling.html"><strong aria-hidden="true">6.2.</strong> Error Handling</a></li><li class="chapter-item "><a href="ch06-03-concurrency.html"><strong aria-hidden="true">6.3.</strong> Concurrency</a></li><li class="chapter-item "><a href="ch06-04-memory.html"><strong aria-hidden="true">6.4.</strong> Memory Management</a></li></ol></li><li class="chapter-item expanded "><li class="spacer"></li><li class="chapter-item expanded "><a href="ch07-00-text-processing-tdd.html"><strong aria-hidden="true">7.</strong> Chapter 7: Text Processing</a><a class="toggle"><div>❱</div></a></li><li><ol class="section"><li class="chapter-item "><a href="ch07-01-string-ops.html"><strong aria-hidden="true">7.1.</strong> String Operations</a></li><li class="chapter-item "><a href="ch07-02-pattern-matching.html"><strong aria-hidden="true">7.2.</strong> Pattern Matching</a></li><li class="chapter-item "><a href="ch07-03-text-analysis.html"><strong aria-hidden="true">7.3.</strong> Text Analysis</a></li></ol></li><li class="chapter-item expanded "><a href="ch08-00-data-analysis-tdd.html"><strong aria-hidden="true">8.</strong> Chapter 8: Data Science Analytics</a><a class="toggle"><div>❱</div></a></li><li><ol class="section"><li class="chapter-item "><a href="ch08-01-statistics.html"><strong aria-hidden="true">8.1.</strong> Statistical Analysis: Iris Dataset</a></li><li class="chapter-item "><a href="ch08-02-aggregation.html"><strong aria-hidden="true">8.2.</strong> Demographic Analysis: Titanic Dataset</a></li><li class="chapter-item "><a href="ch08-03-visualization.html"><strong aria-hidden="true">8.3.</strong> Regression Analysis: Boston Housing</a></li><li class="chapter-item "><a href="ch08-04-correlation.html"><strong aria-hidden="true">8.4.</strong> Feature Correlation: Wine Quality</a></li></ol></li><li class="chapter-item expanded "><a href="ch09-01-wasm-analysis.html"><strong aria-hidden="true">9.</strong> Chapter 9: WASM Analysis</a></li><li class="chapter-item expanded "><a href="ch09-00-file-operations-tdd.html"><strong aria-hidden="true">10.</strong> Chapter 10: File Operations</a><a class="toggle"><div>❱</div></a></li><li><ol class="section"><li class="chapter-item "><a href="ch09-01-read-write.html"><strong aria-hidden="true">10.1.</strong> Reading and Writing</a></li><li class="chapter-item "><a href="ch09-02-processing.html"><strong aria-hidden="true">10.2.</strong> File Processing</a></li><li class="chapter-item "><a href="ch09-03-batch-ops.html"><strong aria-hidden="true">10.3.</strong> Batch Operations</a></li></ol></li><li class="chapter-item expanded "><a href="ch10-00-math-calculations-tdd.html"><strong aria-hidden="true">11.</strong> Chapter 11: Math Calculations</a><a class="toggle"><div>❱</div></a></li><li><ol class="section"><li class="chapter-item "><a href="ch10-01-basic-math.html"><strong aria-hidden="true">11.1.</strong> Basic Mathematics</a></li><li class="chapter-item "><a href="ch10-02-number-theory.html"><strong aria-hidden="true">11.2.</strong> Number Theory</a></li><li class="chapter-item "><a href="ch10-03-advanced-math.html"><strong aria-hidden="true">11.3.</strong> Advanced Calculations</a></li></ol></li><li class="chapter-item expanded "><a href="ch11-00-system-scripting-tdd.html"><strong aria-hidden="true">12.</strong> Chapter 12: System Scripting</a><a class="toggle"><div>❱</div></a></li><li><ol class="section"><li class="chapter-item "><a href="ch11-01-system-info.html"><strong aria-hidden="true">12.1.</strong> System Information</a></li><li class="chapter-item "><a href="ch11-02-processes.html"><strong aria-hidden="true">12.2.</strong> Process Management</a></li><li class="chapter-item "><a href="ch11-03-network.html"><strong aria-hidden="true">12.3.</strong> Network Operations</a></li></ol></li><li class="chapter-item expanded "><a href="ch12-00-functional-chains-tdd.html"><strong aria-hidden="true">13.</strong> Chapter 13: Functional Chains</a><a class="toggle"><div>❱</div></a></li><li><ol class="section"><li class="chapter-item "><a href="ch12-01-composition.html"><strong aria-hidden="true">13.1.</strong> Chain Composition</a></li><li class="chapter-item "><a href="ch12-02-transformation.html"><strong aria-hidden="true">13.2.</strong> Data Transformation</a></li><li class="chapter-item "><a href="ch12-03-advanced-pipelines.html"><strong aria-hidden="true">13.3.</strong> Advanced Pipelines</a></li></ol></li><li class="chapter-item expanded "><li class="spacer"></li><li class="chapter-item expanded "><a href="ch13-00-testing-tdd.html"><strong aria-hidden="true">14.</strong> Chapter 14: Testing Your Code</a></li><li class="chapter-item expanded "><a href="ch14-00-performance-tdd.html"><strong aria-hidden="true">15.</strong> Chapter 15: Performance Optimization</a></li><li class="chapter-item expanded "><a href="ch15-00-best-practices-tdd.html"><strong aria-hidden="true">16.</strong> Chapter 16: Best Practices</a></li><li class="chapter-item expanded affix "><li class="spacer"></li><li class="chapter-item expanded "><a href="appendix-a-installation.html"><strong aria-hidden="true">17.</strong> Appendix A: Installation Guide</a></li><li class="chapter-item expanded "><a href="appendix-b-repl-reference.html"><strong aria-hidden="true">18.</strong> Appendix B: REPL Quick Reference</a></li><li class="chapter-item expanded "><a href="appendix-c-one-liner-patterns.html"><strong aria-hidden="true">19.</strong> Appendix C: One-Liner Patterns</a></li><li class="chapter-item expanded "><a href="appendix-d-troubleshooting.html"><strong aria-hidden="true">20.</strong> Appendix D: Troubleshooting</a></li><li class="chapter-item expanded "><a href="appendix-e-resources.html"><strong aria-hidden="true">21.</strong> Appendix E: Resources</a></li><li class="chapter-item expanded affix "><li class="spacer"></li></ol>';
        // Set the current, active page, and reveal it if it's hidden
        let current_page = document.location.href.toString().split("#")[0].split("?")[0];
        if (current_page.endsWith("/")) {
            current_page += "index.html";
        }
        var links = Array.prototype.slice.call(this.querySelectorAll("a"));
        var l = links.length;
        for (var i = 0; i < l; ++i) {
            var link = links[i];
            var href = link.getAttribute("href");
            if (href && !href.startsWith("#") && !/^(?:[a-z+]+:)?\/\//.test(href)) {
                link.href = path_to_root + href;
            }
            // The "index" page is supposed to alias the first chapter in the book.
            if (link.href === current_page || (i === 0 && path_to_root === "" && current_page.endsWith("/index.html"))) {
                link.classList.add("active");
                var parent = link.parentElement;
                if (parent && parent.classList.contains("chapter-item")) {
                    parent.classList.add("expanded");
                }
                while (parent) {
                    if (parent.tagName === "LI" && parent.previousElementSibling) {
                        if (parent.previousElementSibling.classList.contains("chapter-item")) {
                            parent.previousElementSibling.classList.add("expanded");
                        }
                    }
                    parent = parent.parentElement;
                }
            }
        }
        // Track and set sidebar scroll position
        this.addEventListener('click', function(e) {
            if (e.target.tagName === 'A') {
                sessionStorage.setItem('sidebar-scroll', this.scrollTop);
            }
        }, { passive: true });
        var sidebarScrollTop = sessionStorage.getItem('sidebar-scroll');
        sessionStorage.removeItem('sidebar-scroll');
        if (sidebarScrollTop) {
            // preserve sidebar scroll position when navigating via links within sidebar
            this.scrollTop = sidebarScrollTop;
        } else {
            // scroll sidebar to current active section when navigating via "next/previous chapter" buttons
            var activeSection = document.querySelector('#sidebar .active');
            if (activeSection) {
                activeSection.scrollIntoView({ block: 'center' });
            }
        }
        // Toggle buttons
        var sidebarAnchorToggles = document.querySelectorAll('#sidebar a.toggle');
        function toggleSection(ev) {
            ev.currentTarget.parentElement.classList.toggle('expanded');
        }
        Array.from(sidebarAnchorToggles).forEach(function (el) {
            el.addEventListener('click', toggleSection);
        });
    }
}
window.customElements.define("mdbook-sidebar-scrollbox", MDBookSidebarScrollbox);
