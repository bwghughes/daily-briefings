# EXO Labs Daily Briefing — 2026-04-18

> **Stars:** 43.3k (exo-explore/exo) | **Forks:** 2,983 | Latest release: **v1.0.70** (Apr 17)

---

## Overview

EXO Labs builds EXO, the open-source distributed AI inference platform for Apple Silicon and NVIDIA hardware. It turns heterogeneous hardware — Mac Minis, Mac Studios, DGX Spark systems, laptops — into a unified inference cluster, with automatic workload splitting between compute-bound (prefill) and bandwidth-bound (decode) phases.

**New users:** Start at [exolabs.net](https://www.exolabs.net) or the [GitHub repo](https://github.com/exo-explore/exo). The macOS app handles cluster discovery automatically.

---

## Adoption Stories

- **[High]** **DeepSeek V3 671B on 8× M4 Mac Mini Cluster** — EXO's Day 2 blog post from the "12 Days of EXO" series shows the 671B MoE model running at **5.37 tok/s** (vs Llama 70B at 3.89 tok/s), with TTFT of 2.91s. The secret: MoE models only activate a subset of parameters per token, and Apple Silicon's high memory-bandwidth-to-FLOPS ratio suits batch_size=1 inference perfectly.
  — <https://blog.exolabs.net/day-2/>

- **[High]** **NVIDIA DGX Spark + M3 Ultra Mac Studio — 2.8× benchmark gain** — EXO 1.0 (early access) splits inference phases across hardware: DGX Spark handles compute-heavy prefill, M3 Ultra handles bandwidth-heavy decode via KV cache streaming layer-by-layer. Tested on Llama-3.1 8B with 8K-token prompts.
  — <https://blog.exolabs.net/nvidia-dgx-spark/>
  — <https://www.tomshardware.com/software/two-nvidia-dgx-spark-systems-combined-with-m3-ultra-mac-studio-to-create-blistering-llm-system-exo-labs-demonstrates-disaggregated-ai-inference-and-achieves-a-2-8-benchmark-boost>

- **[Med]** **Two Macs into an 80B AI Cluster** — A developer's Medium post walks through turning two ordinary Macs into an 80B-capable cluster using EXO. The approach lower-bounds the cost of entry for serious local AI.
  — <https://medium.com/@manjunath.shiva/i-turned-two-macs-into-an-80b-ai-cluster-for-free-exo-is-the-open-source-tool-youve-been-waiting-ffa14b8e8dc0>

- **[Med]** **EXO Framework: Run 70B+ Models Across Multiple GPUs** — ToolHalla published a practical guide covering EXO's architecture, RDMA setup, and tensor sharding strategies for running 70B+ models on consumer-grade hardware.
  — <https://toolhalla.ai/blog/exo-framework-distributed-inference-guide-2026>

- **[Med]** **Distributed LLM Comparison** — SharedLLM's 2026 comparison ranks EXO among Petals and Kalavai for distributed inference networks.
  — <https://sharedllm.org/blog/sharedllm-vs-petals-vs-exo-vs-kalavai.html>

---

## Technical Updates

- **[High]** **v1.0.70 released (Apr 17)** — This is the biggest release since v1.0.68. Key additions:
  - **Multimodality & vision models**: Vision processors now supported in Qwen3.5, Kimi K2.5, and Gemma 4. PDFs handled by sending both text and image.
  - **New models**: Gemma 4, Minimax M2.7, Qwen3.6 added.
  - **Flash Attention for Qwen3.5 & Gemma 4**: Reduces peak memory consumption by **3–6×**.
  - **Memory fixes**: Rotating/Arrays cache memory leaks fixed (#1819, #1835); KV cache garbage collection on eviction (#1832); improved KV prefix cache hit rates.
  - **Bug fixes**: Zombie process handling for RDMA resources (#1889), out-of-order event crashes on startup (#1894), malformed tool calls in thinking parsing (#1898).
  — <https://github.com/exo-explore/exo/releases/tag/v1.0.70>

- **[High]** **v1.0.69 released (Mar 27)** — Continuous batching is now **on by default**, enabling parallel inference requests across single and multi-node (including RDMA) setups. Great for agentic workflows. Also added: Qwen3.5 support, M5 Pro/Max chip support, better pipeline parallel prefill (1.98× faster on 2 nodes).
  — <https://github.com/exo-explore/exo/releases/tag/v1.0.69>

- **[Med]** **v1.0.68 released (Feb 25)** — "Biggest EXO release to date." Claude Messages API support (enables Claude Code), OpenAI Responses API, Ollama API compatibility, redesigned web dashboard, redesigned model picker, log rotation to `~/.exo/exo_logs`, M5 chip support, and FLUX.1 image generation improvements.
  — <https://github.com/exo-explore/exo/releases/tag/v1.0.68>

- **[Med]** **PR #1211 merged: Load layers individually** — Collaborator @rltakashige merged the `leo/load-layers-individually` branch, enabling finer-grained layer distribution across nodes.
  — <https://github.com/exo-explore/exo/pull/1211>

- **[Med]** **Issue #1850: KV cache compression for distributed inference** — Open issue from Apr 7 proposing memory savings via KV cache compression in distributed inference settings.
  — <https://github.com/exo-explore/exo/issues/1850>

- **[Med]** **Issue #1872: GPU memory leak — VRAM not released after session termination** — Open bug (Apr 13) reporting VRAM persists across process restarts. Affects production use.
  — <https://github.com/exo-explore/exo/issues/1872>

- **[Med]** **Issue #1709: Can't place models close to memory limits** — Open bug (Mar 12) on placement constraints, updated Apr 12.
  — <https://github.com/exo-explore/exo/issues/1709>

---

## Community Pulse

- **[Med]** **Hacker News: "11 tok/SEC running 671B DeepSeek R1 on two M3 Ultra"** — A March 2025 HN post (resurfaced) by Alex Cheema showed the two-M3-Ultra setup achieving 11 tok/s on DeepSeek R1 671B. Commenters noted the emerging trend toward local "mainframe" setups for enterprises replacing paper-processing workflows.
  — <https://news.ycombinator.com/item?id=43341684>

- **[Med]** **Hacker News: Exo home cluster** — Earlier HN thread on running your own AI cluster at home. Discussion noted the Apple Silicon focus via MLX and raised questions about cross-platform support.
  — <https://news.ycombinator.com/item?id=40973339>

- **[Low]** **r/LocalLLaMA: AI Developer Tools Map (2026)** — EXO appears in the community's 2026 tools map as a recommended option for distributed inference.
  — <https://www.reddit.com/r/LocalLLaMA/comments/1r47a79/ai_developer_tools_map_2026_edition/>

- **[Low]** **DEV Community: Local LLM Inference 2026 Guide** — EXO is covered alongside Ollama as a tool for running open-weight models locally.
  — <https://dev.to/starmorph/local-llm-inference-in-2026-the-complete-guide-to-tools-hardware-open-weight-models-2iho>

- **[Low]** **Security: Unauthenticated RCE in EXO** — Immersive Labs published a security advisory on an unauthenticated RCE in open-source AI platforms including EXO. No evidence of active exploitation noted, but worth tracking.
  — <https://www.immersivelabs.com/resources/c7-blog/unauthenticated-rce-in-exo-why-the-security-architecture-of-open-source-ai-platforms-needs-immediate-attention>

---

## Market Signals

- **[Med]** **Tom's Hardware: DGX Spark + Mac Studio disaggregated inference** — In-depth coverage of EXO Labs' hybrid NVIDIA+Apple setup demonstrating 2.8× gains. Article notes NVIDIA's own Rubin CPX platform will use the same prefill/decode disaggregation principle — validating the approach before NVIDIA's own hardware ships.
  — <https://www.tomshardware.com/software/two-nvidia-dgx-spark-systems-combined-with-m3-ultra-mac-studio-to-create-blistering-llm-system-exo-labs-demonstrates-disaggregated-ai-inference-and-achieves-a-2-8-benchmark-boost>

- **[Med]** **Starthub Asia: Run powerful open-source AI models locally on Mac M4** — Coverage of EXO Labs enabling local running of the most powerful open-source models on Mac M4 computers.
  — <https://starthub.asia/you-can-now-run-the-most-powerful-open-source-ai-models-locally-on-mac-m4-computers-thanks-to-exo-labs/>

- **[Med]** **Inkl (news aggregator): DGX Spark + M3 Ultra Mac Studio** — Syndicated coverage of the Tom's Hardware story.
  — <https://www.inkl.com/news/two-nvidia-dgx-spark-systems-fused-with-m3-ultra-mac-studio-to-deliver-2-8x-gain-in-ai-benchmarks-exo-labs-demonstrates-disaggregated-ai-inference-serving>

---

## Trends

| Signal | Direction |
|---|---|
| v1.0.70 multimodality + vision models | ↗ New capability |
| Continuous batching on by default (v1.0.69) | ↗ Performance leap |
| Flash Attention 3–6× memory reduction | ↗ Efficiency gain |
| DGX Spark + Mac Studio hybrid showing 2.8× | ↗ Validation of disaggregated approach |
| M5 Pro/Max chip support | ↗ New Apple hardware |
| Open security advisory (RCE) | ⚠ Area of concern |
| KV cache compression issue filed | 🔄 In progress |

---

## Quick Links

| Resource | URL |
|---|---|
| GitHub (43.3k ★) | <https://github.com/exo-explore/exo> |
| Releases | <https://github.com/exo-explore/exo/releases> |
| Blog | <https://blog.exolabs.net> |
| 12 Days of EXO | <https://blog.exolabs.net/> |
| EXO Main Site | <https://www.exolabs.net> |
| EXO v1.0.70 Release | <https://github.com/exo-explore/exo/releases/tag/v1.0.70> |
| DeepSeek V3 671B on M4 Mac Mini | <https://blog.exolabs.net/day-2/> |
| DGX Spark + Mac Studio | <https://blog.exolabs.net/nvidia-dgx-spark/> |

---
*Compiled 2026-04-18 by Cilla for EXO Labs Daily Briefing*