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
        this.innerHTML = '<ol class="chapter"><li class="chapter-item expanded affix "><a href="title-page.html">Ruchy WebAssembly &amp; REPL Mastery</a></li><li class="chapter-item expanded affix "><a href="introduction.html">Introduction</a></li><li class="chapter-item expanded affix "><li class="spacer"></li><li class="chapter-item expanded "><a href="ch01-00-wasm-basics-tdd.html"><strong aria-hidden="true">1.</strong> Chapter 1: WASM Basics</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch01-01-wasm-arithmetic.html"><strong aria-hidden="true">1.1.</strong> WASM Arithmetic &amp; Compilation</a></li><li class="chapter-item expanded "><a href="ch01-02-wasm-variables.html"><strong aria-hidden="true">1.2.</strong> WASM Variables &amp; Memory</a></li><li class="chapter-item expanded "><a href="ch01-03-wasm-strings.html"><strong aria-hidden="true">1.3.</strong> WASM Strings &amp; Text Processing</a></li><li class="chapter-item expanded "><a href="ch01-04-wasm-booleans.html"><strong aria-hidden="true">1.4.</strong> WASM Boolean Logic</a></li><li class="chapter-item expanded "><a href="ch01-05-wasm-arrays.html"><strong aria-hidden="true">1.5.</strong> WASM Arrays &amp; Collections</a></li></ol></li><li class="chapter-item expanded "><a href="ch02-00-wasm-functions-tdd.html"><strong aria-hidden="true">2.</strong> Chapter 2: WASM Functions</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch02-01-wasm-basic-functions.html"><strong aria-hidden="true">2.1.</strong> Basic WASM Function Export</a></li><li class="chapter-item expanded "><a href="ch02-02-wasm-recursion.html"><strong aria-hidden="true">2.2.</strong> WASM Recursion Patterns</a></li><li class="chapter-item expanded "><a href="ch02-03-wasm-closures.html"><strong aria-hidden="true">2.3.</strong> WASM Closures &amp; Scope</a></li><li class="chapter-item expanded "><a href="ch02-04-wasm-higher-order.html"><strong aria-hidden="true">2.4.</strong> WASM Higher-Order Functions</a></li><li class="chapter-item expanded "><a href="ch02-05-wasm-composition.html"><strong aria-hidden="true">2.5.</strong> WASM Function Composition</a></li></ol></li><li class="chapter-item expanded "><a href="ch03-00-wasm-data-structures-tdd.html"><strong aria-hidden="true">3.</strong> Chapter 3: WASM Data Structures</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch03-01-wasm-arrays-vectors.html"><strong aria-hidden="true">3.1.</strong> WASM Arrays and Linear Memory</a></li><li class="chapter-item expanded "><a href="ch03-02-wasm-hashmaps-structs.html"><strong aria-hidden="true">3.2.</strong> WASM Structs &amp; Memory Layout</a></li><li class="chapter-item expanded "><a href="ch03-03-wasm-advanced-collections.html"><strong aria-hidden="true">3.3.</strong> WASM Advanced Collections</a></li><li class="chapter-item expanded "><a href="ch03-04-wasm-tree-graph.html"><strong aria-hidden="true">3.4.</strong> WASM Tree and Graph Structures</a></li></ol></li><li class="chapter-item expanded "><a href="ch04-00-wasm-algorithms-tdd.html"><strong aria-hidden="true">4.</strong> Chapter 4: WASM Algorithms</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch04-01-wasm-sorting.html"><strong aria-hidden="true">4.1.</strong> WASM Sorting Algorithms</a></li><li class="chapter-item expanded "><a href="ch04-02-wasm-searching.html"><strong aria-hidden="true">4.2.</strong> WASM Search Algorithms</a></li><li class="chapter-item expanded "><a href="ch04-03-wasm-graphs.html"><strong aria-hidden="true">4.3.</strong> WASM Graph Algorithms</a></li><li class="chapter-item expanded "><a href="ch04-04-wasm-dynamic-programming.html"><strong aria-hidden="true">4.4.</strong> WASM Dynamic Programming</a></li></ol></li><li class="chapter-item expanded "><a href="ch05-00-wasm-functional-tdd.html"><strong aria-hidden="true">5.</strong> Chapter 5: WASM Functional Programming</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch05-01-wasm-map-filter-reduce.html"><strong aria-hidden="true">5.1.</strong> WASM Map, Filter, Reduce</a></li><li class="chapter-item expanded "><a href="ch05-02-wasm-pipelines.html"><strong aria-hidden="true">5.2.</strong> WASM Pipeline Operations</a></li><li class="chapter-item expanded "><a href="ch05-03-wasm-advanced-functional.html"><strong aria-hidden="true">5.3.</strong> WASM Advanced Functional Patterns</a></li></ol></li><li class="chapter-item expanded "><li class="spacer"></li><li class="chapter-item expanded "><a href="ch06-00-browser-wasm-tdd.html"><strong aria-hidden="true">6.</strong> Chapter 6: Browser WASM</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch06-01-js-wasm-interop.html"><strong aria-hidden="true">6.1.</strong> JavaScript WASM Interop</a></li><li class="chapter-item expanded "><a href="ch06-02-dom-integration.html"><strong aria-hidden="true">6.2.</strong> DOM Integration Patterns</a></li><li class="chapter-item expanded "><a href="ch06-03-browser-performance.html"><strong aria-hidden="true">6.3.</strong> WASM Performance in Browser</a></li><li class="chapter-item expanded "><a href="ch06-04-wasm-memory.html"><strong aria-hidden="true">6.4.</strong> WASM Memory Management</a></li></ol></li><li class="chapter-item expanded "><a href="ch07-00-nodejs-wasm-tdd.html"><strong aria-hidden="true">7.</strong> Chapter 7: Node.js WASM</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch07-01-nodejs-modules.html"><strong aria-hidden="true">7.1.</strong> Node.js WASM Modules</a></li><li class="chapter-item expanded "><a href="ch07-02-server-processing.html"><strong aria-hidden="true">7.2.</strong> Server-Side Processing</a></li><li class="chapter-item expanded "><a href="ch07-03-wasm-text-analysis.html"><strong aria-hidden="true">7.3.</strong> WASM Text Analysis</a></li></ol></li><li class="chapter-item expanded "><a href="ch08-00-cloudflare-wasm-tdd.html"><strong aria-hidden="true">8.</strong> Chapter 8: Cloudflare Workers</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch08-01-worker-deployment.html"><strong aria-hidden="true">8.1.</strong> Worker WASM Deployment</a></li><li class="chapter-item expanded "><a href="ch08-02-edge-processing.html"><strong aria-hidden="true">8.2.</strong> Edge Data Processing</a></li><li class="chapter-item expanded "><a href="ch08-03-global-distribution.html"><strong aria-hidden="true">8.3.</strong> Global WASM Distribution</a></li><li class="chapter-item expanded "><a href="ch08-04-edge-analytics.html"><strong aria-hidden="true">8.4.</strong> Edge Analytics WASM</a></li></ol></li><li class="chapter-item expanded "><a href="ch09-00-lambda-wasm-tdd.html"><strong aria-hidden="true">9.</strong> Chapter 9: AWS Lambda WASM</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch09-01-lambda-functions.html"><strong aria-hidden="true">9.1.</strong> Lambda WASM Functions</a></li><li class="chapter-item expanded "><a href="ch09-02-serverless-processing.html"><strong aria-hidden="true">9.2.</strong> Serverless File Processing</a></li><li class="chapter-item expanded "><a href="ch09-03-wasm-batch-ops.html"><strong aria-hidden="true">9.3.</strong> WASM Batch Operations</a></li></ol></li><li class="chapter-item expanded "><a href="ch10-00-math-wasm-tdd.html"><strong aria-hidden="true">10.</strong> Chapter 10: High-Performance Math</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch10-01-wasm-basic-math.html"><strong aria-hidden="true">10.1.</strong> WASM Mathematical Operations</a></li><li class="chapter-item expanded "><a href="ch10-02-wasm-number-theory.html"><strong aria-hidden="true">10.2.</strong> WASM Number Theory</a></li><li class="chapter-item expanded "><a href="ch10-03-wasm-advanced-math.html"><strong aria-hidden="true">10.3.</strong> WASM Advanced Calculations</a></li></ol></li><li class="chapter-item expanded "><a href="ch11-00-system-wasm-tdd.html"><strong aria-hidden="true">11.</strong> Chapter 11: Cross-Platform WASM</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch11-01-wasi-system-info.html"><strong aria-hidden="true">11.1.</strong> WASI System Information</a></li><li class="chapter-item expanded "><a href="ch11-02-wasm-processes.html"><strong aria-hidden="true">11.2.</strong> WASM Process Management</a></li><li class="chapter-item expanded "><a href="ch11-03-wasm-network.html"><strong aria-hidden="true">11.3.</strong> WASM Network Operations</a></li></ol></li><li class="chapter-item expanded "><a href="ch12-00-wasm-chains-tdd.html"><strong aria-hidden="true">12.</strong> Chapter 12: WASM Functional Chains</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch12-01-wasm-composition.html"><strong aria-hidden="true">12.1.</strong> WASM Chain Composition</a></li><li class="chapter-item expanded "><a href="ch12-02-wasm-transformation.html"><strong aria-hidden="true">12.2.</strong> WASM Data Transformation</a></li><li class="chapter-item expanded "><a href="ch12-03-wasm-advanced-pipelines.html"><strong aria-hidden="true">12.3.</strong> WASM Advanced Pipelines</a></li></ol></li><li class="chapter-item expanded "><li class="spacer"></li><li class="chapter-item expanded "><a href="ch13-00-wasm-testing-tdd.html"><strong aria-hidden="true">13.</strong> Chapter 13: WASM Testing</a></li><li class="chapter-item expanded "><a href="ch14-00-wasm-performance-tdd.html"><strong aria-hidden="true">14.</strong> Chapter 14: WASM Performance Optimization</a></li><li class="chapter-item expanded "><a href="ch15-00-wasm-best-practices-tdd.html"><strong aria-hidden="true">15.</strong> Chapter 15: WASM Best Practices</a></li><li class="chapter-item expanded affix "><li class="spacer"></li><li class="chapter-item expanded "><a href="appendix-a-installation.html"><strong aria-hidden="true">16.</strong> Appendix A: Installation Guide</a></li><li class="chapter-item expanded "><a href="appendix-b-repl-reference.html"><strong aria-hidden="true">17.</strong> Appendix B: REPL Quick Reference</a></li><li class="chapter-item expanded "><a href="appendix-c-one-liner-patterns.html"><strong aria-hidden="true">18.</strong> Appendix C: One-Liner Patterns</a></li><li class="chapter-item expanded "><a href="appendix-d-troubleshooting.html"><strong aria-hidden="true">19.</strong> Appendix D: Troubleshooting</a></li><li class="chapter-item expanded "><a href="appendix-e-resources.html"><strong aria-hidden="true">20.</strong> Appendix E: Resources</a></li><li class="chapter-item expanded affix "><li class="spacer"></li></ol>';
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
