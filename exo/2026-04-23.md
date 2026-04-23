# EXO Labs Daily Briefing — 2026-04-23

**Generated:** Thursday, April 23rd, 2026 | 05:08 AM (Europe/London)

---

## 🚀 Overview

EXO is an open-source distributed AI inference platform enabling Apple Silicon and NVIDIA hardware to collaboratively run frontier-scale models (70B–671B+ parameters). It shards models across devices using pipeline parallelism, with RDMA/Thunderbolt support for low-latency inter-node communication. **43.3K GitHub stars**, 2,983 forks. Version **v1.0.70** shipped April 17th with major multimodality and vision model support.

---

## 📦 Adoption Stories

**[High] GK SERVIS: Private LLM Cluster — Mac Studio + MLX RDMA**
A case study from GK SERVIS documenting a **4-node Mac Studio cluster** configured for private, zero-cloud-dependency inference of trillion-parameter models. Highlights RDMA networking between Mac Studio nodes for tight-latency tensor parallel workloads.
→ https://www.gkservis.com/case-studies/llm-inference-cluster.html

**[High] HN: Nvidia DGX Spark + Apple Mac Studio = 4x Faster LLM Inference with EXO 1.0**
A Hacker News thread (61 points) covering hybrid NVIDIA DGX Spark + Apple Mac Studio configurations delivering **4x throughput gains** via EXO's heterogeneous cluster support and continuous batching.
→ https://news.ycombinator.com/item?id=45611912 | https://blog.exolabs.net/nvidia-dgx-spark/

**[Med] "I Turned Two Macs Into an 80B AI Cluster for Free" — Medium**
A hands-on walkthrough by Manjunath Janardhan showing how to pool two commodity Macs into a distributed inference cluster running Llama 80B via EXO + MLX, no cloud required.
→ https://medium.com/@manjunath.shiva/i-turned-two-macs-into-an-80b-ai-cluster-for-free-exo-is-the-open-source-tool-youve-been-waiting-ffa14b8e8dc0

**[Med] DeepSeek V3 671B on 8x M4 Pro Mac Mini Cluster — Official Blog**
EXO's own Day 2 of the "12 Days of EXO" series benchmarks DeepSeek V3 671B (4-bit) on an **8-node M4 Pro 64GB Mac Mini cluster** (512GB total unified memory): **TTFT 2.91s, TPS 5.37**. The 671B MoE model runs *faster* than Llama 70B in this setup, because only ~37B experts activate per token vs. all 70B params for dense models.
→ https://blog.exolabs.net/day-2/

**[Med] MacBook MacBook Cluster Tutorial — Markaicode**
Step-by-step guide to clustering spare MacBooks into a unified AI inference engine using EXO's mDNS peer discovery.
→ https://markaicode.com/run-distributed-ai-exo-macbooks/

**[Low] Self-Hosting Llama-70B on Apple Silicon with EXO + MLX**
Akshat Rai Laddha's Medium walkthrough for solo M-series Mac owners wanting to fit 70B via EXO sharding.
→ https://medium.com/@laddhaakshatrai/self-hosting-llama-70b-on-apple-silicon-hardware-with-exo-and-mlx-30bb6201f04e

---

## ⚙️ Technical Updates

### GitHub Activity (Last 2 Weeks)

**Latest commit (April 17, 2026):**
- `Improve build CI` — CI pipeline hardening (#1920)
- `fix: force gc + clear_cache after KV prefix cache eviction` — memory management fix (#1832)
- `Add model card for Qwen3.6-35B-A3B-8bit` (#1917)

**v1.0.70 — April 17, 2026** (Major Release)
- **New model support:** Gemma 4, Minimax M2.7, Qwen3.6
- **Flash Attention** implemented for Qwen3.5 and Gemma 4 → **3–6x reduction in peak memory** consumption
- **Multimodality:** Vision model support for Qwen3.5, Kimi K2.5, and Gemma 4
- **PDF handling:** Sends both text + image renders to vision-capable models
- **Memory fixes:** KV cache leak fixes (#1819, #1835), improved prefix cache hit rates (#1817), forced GC on cache eviction
- **API:** OpenCode/n8n/OpenClaw one-click setup helpers, Firefox AI sidebar support, `/state/paths` endpoint
- **Bug fixes:** RDMA zombie process cleanup, out-of-order event crash on startup, thinking-mode parsing edge cases
→ https://github.com/exo-explore/exo/releases/tag/v1.0.70

**v1.0.69 — March 27, 2026**
- **Continuous batching ON BY DEFAULT** — multiple concurrent requests batched automatically, significant throughput gains for agentic workloads
- **Better pipeline parallel prefill:** Prompt chunks split and overlapped with computation → **1.98x faster prefill on 2 nodes**
- New models: Qwen3.5, DeepSeek v3.2 default cards, Nemotron sharding
- M5 Pro/Max support; macmon upgrade fixes memory/GPU stat reporting
- Static peer discovery via `--bootstrap-peers` flag (bypasses mDNS)
→ https://github.com/exo-explore/exo/releases/tag/v1.0.69

**v1.0.68 — February 25, 2026** (Previous Major)
- **Claude Messages API + OpenAI Responses API** — enables Claude Code, OpenCode
- **Ollama API** compatibility layer
- GLM-5 support (1.5TB model), MiniMax M2.5, Qwen3-Coder-Next, Step 3.5 Flash
- Image generation: FLUX.1-Kontext-dev, parallel CFG for Qwen image models
- Major GPU lock fix (MLX_METAL_FAST_SYNCH regression across Ring instances)
- Redesigned model picker, onboarding flow, prefill progress bar
→ https://github.com/exo-explore/exo/releases/tag/v1.0.68

---

## 💬 Community Pulse

**Hacker News**
- DGX Spark + Mac Studio hybrid setup trending with 61 points [High]
- Discussion on distributed inference bottleneck: inter-GPU connection latency vs. bandwidth — EXO's pipeline parallel approach validated in comments [Med]
- Original EXO launch thread (2024) still getting inbound discussion on multi-device support [Low]

**r/LocalLLaMA**
- Threads on GLM-5 (1.5TB) spurring broader "why hasn't distributed inference taken off?" discussion [Med]
- Best coding LLMs for M4 Mac Mini (Feb 2026) — EXO cited as viable for multi-model setups [Med]
- French-language thread on EXO crashing on Mac (OpenClaw context) [Low]

**Discord**
- EXO Discord community actively discussing heterogeneous cluster scheduling, tensor parallelism roadmap
- Community-requested function call integrations for the EXOcortex agent (Day 3 blog feature)

---

## 📰 Market Signals

**ToolHalla: EXO Framework — Run 70B+ Models Across Multiple GPUs (2026)**
A comprehensive guide covering EXO for multi-GPU (non-Apple) setups, explaining pipeline parallel sharding, memory estimation, and throughput benchmarks.
→ https://toolhalla.ai/blog/exo-framework-distributed-inference-guide-2026

**DeepWiki: EXO Distributed Parallelism + RDMA over Thunderbolt**
Technical deep-dive into EXO's parallelism implementation, including RDMA over Thunderbolt for Mac-native clusters.
→ https://deepwiki.com/exo-explore/exo/5.4-rdma-over-thunderbolt

**PitchBook (2026 Profile)**
- Exo Labs: ~187 employees, Series D ($43.9M latest deal), 37 investors
- Year founded listed as 2015; current status: Private
→ https://pitchbook.com/profiles/company/164065-96

---

## 🔮 Trends & Outlook

1. **MoE > Dense at the edge:** DeepSeek V3 671B outperforming Llama 70B on Mac clusters confirms Mixture-of-Experts architecture is the sweet spot for unified-memory hardware — only a fraction of params activate per token.

2. **Multimodality lands in EXO:** v1.0.70's vision model support (Qwen3.5, Kimi K2.5, Gemma 4) with PDF handling marks EXO's expansion beyond pure text inference into document understanding — key for enterprise use cases.

3. **Continuous batching = throughput unlock:** v1.0.69's default-on batching dramatically improves real-world throughput for agentic/multi-user scenarios without any user configuration.

4. **Hybrid Mac + NVIDIA clusters:** HN signal suggests growing interest in heterogeneous Apple+NVIDIA setups, potentially for orgs with mixed hardware fleets seeking unified inference infrastructure.

5. **Enterprise traction:** The GK SERVIS case study, 187-employee headcount, and Series D funding indicate genuine enterprise adoption beyond hobbyists.

---

## 🔗 Quick Links

| Resource | URL |
|---|---|
| GitHub (43.3K ⭐) | https://github.com/exo-explore/exo |
| Blog | https://blog.exolabs.net |
| Benchmarks | https://benchmarks.exolabs.net/ |
| Discord | https://discord.gg/EUnjGpsmWw |
| Enterprise | sales@exolabs.net |

---

*Compiled by Cilla | EXO Labs Daily Briefing | 2026-04-23*
