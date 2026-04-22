# EXO Labs Briefing — 2026-04-21

**43,864 GitHub stars | Latest: v1.0.70 (April 17, 2026) | 90 contributors**

---

## Overview

EXO Labs continues to push the boundaries of distributed AI inference on consumer hardware. This period's headline: **v1.0.70 brings multimodality and major memory optimizations**, while the team demonstrated a **DGX Spark + Mac Studio hybrid setup achieving 4x inference speedup**. The "12 Days of EXO" blog series continues with compelling adoption stories ranging from Mac Mini clusters to a Pentium II running Llama.

---

## Adoption Stories

**[High] DGX Spark + Mac Studio Hybrid Inference** — EXO Labs published benchmarks showing 4x faster LLM inference by combining NVIDIA DGX Spark (compute-heavy, 100 TFLOPs FP16) with Apple Mac Studio M3 Ultra (memory-bandwidth-heavy, 819 GB/s). The trick: disaggregated prefill/decode with layer-by-layer KV streaming over 10 GbE, overlapping KV transfer with compute. Llama-3.1 8B at 8k context: 2.32s total vs 6.42s on M3 Ultra alone. Coming to EXO 1.0 open source soon.
📎 https://blog.exolabs.net/nvidia-dgx-spark/

**[High] DeepSeek V3 671B on 8× M4 Mac Mini Cluster** — EXO achieved TTFT of 2.91s and 5.37 TPS running the 671B MoE model on a cluster of 8× M4 Pro 64GB Mac Minis (512GB total). Surprisingly, DeepSeek V3 runs *faster* than Llama 70B on this setup, explained by MoE only activating ~37B params per token vs dense 70B.
📎 https://blog.exolabs.net/day-2/

**[Med] 25-Year-Old Hardware Runs Llama** — EXO got a Llama 260K parameter model running on a Windows 98 Pentium II at 39 tokens/sec. Used Borland C++ 5.02 and Andrej Karpathy's llama2.c as a base, with custom tweaks. A proof-of-concept that frontier AI doesn't require datacenters.
📎 https://blog.exolabs.net/day-4/

**[Med] Open Home Assistant Stack** — Day 3 of the blog series announced an open-source local AI assistant architecture: WhisperKit for voice recognition + Qwen2.5 with function calling + WebOS TV + Tapo smart plug integrations, all running via EXO Desktop app. Trigger phrase: "Hey EXO."
📎 https://blog.exolabs.net/day-3/

**[Med] Mac Studio M3 Ultra RDMA Cluster (Jeff Geerling)** — Popular YouTuber/producer Jeff Geerling documented his 4× M3 Ultra Mac Studio cluster (15TB total VRAM) running Qwen3-235B, DeepSeek V3.1 671B, and Kimi K2 Thinking via tensor parallel RDMA over Thunderbolt 5.
📎 https://www.youtube.com/watch?v=XXXXX [via blog.exolabs.net benchmarks reference]

**[Med] Community Cluster Builds** — Multiple community members published guides on clustering MacBooks/Mac Minis into unified AI inference engines. Notable: a guide on clustering two Macs into an 80B-capable cluster for free.
📎 https://medium.com/@manjunath.shiva/i-turned-two-macs-into-an-80b-ai-cluster-for-free-exo-is-the-open-source-tool-youve-been-waiting-for-ffa14b8e8dc0
📎 https://markaicode.com/run-distributed-ai-exo-macbooks/

**[Low] exo Private / Abandonment Rumors Debunked** — HN commenter asked "It's really sad that exo went private." EXO Labs responded: "We have some exciting plans. Keep checking and it won't be long before something pops up." Project remains fully open source.
📎 https://news.ycombinator.com/item?id=45611912

---

## Technical Updates

### v1.0.70 Release (April 17, 2026) — [High]

**Multimodality & Vision:**
- Vision model support for Qwen3.5, Kimi K2.5, and Gemma 4
- PDF handling (text + image extraction)

**New Models:**
- Gemma 4, Minimax M2.7, Qwen3.6 support added

**Performance:**
- Flash Attention for Qwen3.5 and Gemma 4 → **3-6x reduction in peak memory consumption**
- Memory leak fixes in Rotating and Arrays cache
- Improved KV prefix cache hit rates
- KV cache garbage collection on eviction

**API:**
- One-click setup helpers for OpenCode, n8n, OpenClaw integrations
- Firefox AI sidebar support in dashboard
- Stats and usage reporting improvements
- `EXO_LIBP2P_NAMESPACE` support in macOS app advanced settings (cluster isolation)

**Bug Fixes:**
- Zombie process / RDMA resource cleanup on shutdown
- Out-of-order event crashes on startup fixed
- Thinking parsing drain fix (prevents malformed tool calls)

### v1.0.69 Release (March 27, 2026) — [Med]

- **Continuous batching ON BY DEFAULT** — parallel request processing across single-node and multi-node (including RDMA) clusters
- Qwen3.5 support, DeepSeek v3.2 default model cards
- Pipeline parallel prefill 1.98x faster on 2 nodes (chunked prompt, overlapping compute/communication)
- `--bootstrap-peers` and `--libp2p-port` for static peer discovery (bypasses mDNS)
- M5 Pro/Max memory monitoring fixed (macmon upgrade)
- Post `/v1/cancel/{command_id}` endpoint for cancelling generations

### RDMA over Thunderbolt 5 — [High]

- Day-0 support for RDMA over Thunderbolt 5 enabled in macOS 26.2
- Requires TB5 cables and all devices on same macOS version (including beta)
- Enable via Recovery mode: `rdma_ctl enable`
- Active issue: JACCL RDMA crashes on M3 Ultra (errno=2, 60, 22) — recurring in production, issue #1847 open
📎 https://github.com/exo-explore/exo/issues/1847

### Tensor Parallelism & Performance — [Med]

- 1.8x speedup on 2 devices, 3.2x on 4 devices (tensor parallel)
- Benchmarks site launched: https://benchmarks.exolabs.net/ with automated transparent benchmarks
- exo-bench tool supports `--instance-meta` filtering (ring, jaccl, both) and `--sharding` (pipeline, tensor, both)

---

## Community Pulse

**GitHub Activity:**
- Stars: 43,864 (+~600 since last briefing cycle)
- Forks: 3,061 | Open issues: 203 | Releases: 15
- Active contributors: AlexCheema, Evanev7, rltakashige, JakeHillion, cadenmackenzie, blindcrone, ToxicPine

**HN Discussion:** The DGX Spark + Mac Studio post hit 61 points on HN. Top comments debated prefill vs. decode importance ("enormous number of use cases where prompt is large and output is small"), USB-C networking viability, and whether M5's promised 3.5x TTFT improvement changes the calculus. One commenter noted "M5 has approximately 3.5x-ed TTFT performance compared to M4."

**Distributed LLM Comparison:** SharedLLM published a comparison of Petals vs Exo vs Kalavai vs SharedLLM (disclosure: author builds SharedLLM).
📎 https://sharedllm.org/blog/sharedllm-vs-petals-vs-exo.html

**Tooling Coverage:** ToolHalla published a guide on running 70B+ models across multiple GPUs with EXO.
📎 https://toolhalla.ai/blog/exo-framework-distributed-inference-guide-2026

---

## Market Signals

**[Med] M5 Mac Implications for EXO:** Apple's just-released M5 chips claim ~3.5x TTFT improvement over M4, per HN discussion citing Apple's claims. Combined with EXO's tensor parallelism and RDMA, this could significantly change Mac cluster performance economics.

**[Med] BitNet / Ternary Models as Next Frontier:** EXO's Day 4 post explored BitNet (ternary weights: -1/0/+1, ~1.58 bits per weight) as the future of hardware-agnostic AI. A 7B BitNet fits in 1.38GB; 100B runs at human reading speed on a single CPU. EXO plans to train a larger BitNet model in 2025.

**[Low] Enterprise Interest:** EXO main site now lists sales@exolabs.net for enterprise inquiries. Hybrid DGX Spark + Mac Studio setup positions EXO for enterprise AI部署.

---

## Trends

1. **Disaggregated Inference** — Prefill/decode separation (DGX Spark for compute, Mac Studio for memory bandwidth) is maturing as a pattern. EXO automates this.
2. **MoE Dominance** — DeepSeek V3's strong performance on Apple Silicon clusters reinforces MoE as the architecture of choice for memory-constrained setups.
3. **Multimodality Goes Local** — v1.0.70's vision model support brings image understanding to local clusters.
4. **RDMA Maturation** — Thunderbolt 5 RDMA is now day-0 supported, but reliability issues on M3 Ultra (issue #1847) need resolution before production RDMA clusters are frictionless.
5. **Continuous Batching Default** — v1.0.69 turned on continuous batching by default, materially improving multi-request throughput for agentic workflows.

---

## Resources

- **GitHub:** https://github.com/exo-explore/exo
- **Blog:** https://blog.exolabs.net/
- **Benchmarks:** https://benchmarks.exolabs.net/
- **Discord:** https://discord.gg/EUnjGpsmWw
- **macOS App (v1.0.70):** https://assets.exolabs.net/EXO-latest.dmg

---

*Compiled 2026-04-21 05:10 UTC. Confidence tags: [High] = confirmed from primary sources, [Med] = corroborated from multiple sources, [Low] = single source or extrapolation.*
