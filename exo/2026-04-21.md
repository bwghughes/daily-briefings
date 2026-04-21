# EXO Labs Daily Briefing — 2026-04-20

> **Stars:** 43,261 (+~1,400 in recent months) | **Forks:** 2,983 | **Open Issues:** 174 | **Latest Release:** v1.0.70 (April 17)

---

## 🚀 Overview

EXO Labs just completed their landmark **"12 Days of EXO"** blog series — 12 consecutive days of major technical and product announcements spanning distributed inference, decentralized training, private search, hardware disaggregation, and more. The pace of development has been exceptional. This briefing covers the full picture.

---

## 📖 Adoption Stories

### [High] DeepSeek V3 671B Runs on M4 Mac Mini Cluster — Faster Than Llama 70B!
The standout headline: **DeepSeek V3 671B (4-bit) achieves 5.37 TPS** on an 8× M4 Pro 64GB Mac Mini cluster — dramatically faster than Llama 3.1 70B (3.14 TPS TTFT, 0.88 TPS) despite being ~10× larger. Explained by MoE architecture: only ~37B experts activate per token vs. all 70B params for Llama. The EXO blog breaks down the memory-bandwidth vs. compute-bound dynamics that make Apple Silicon uniquely suited for batch_size=1 inference.

**Source:** https://blog.exolabs.net/day-2/

### [High] NVIDIA DGX Spark + Apple Mac Studio = 4× Faster LLM Inference
EXO 1.0 automates **disaggregated prefill/decode** across heterogeneous hardware. DGX Spark (100 TFLOPs FP16, 128GB memory) handles compute-bound prefill; M3 Ultra (819 GB/s memory bandwidth) handles memory-bound decode. With layer-by-layer KV streaming overlapped with compute, the hybrid achieves 2.8× speedup vs. M3 Ultra alone on Llama-3.1 8B FP16 at 8K context.

**Source:** https://blog.exolabs.net/nvidia-dgx-spark/

### [Med] iPhone Mirroring for Personalised AI Agent
The EXO Desktop App now supports **iPhone Mirroring (WWDC 2024)** natively — one click gives the local LLM access to your phone screen. Already integrated: YouTube watch history, Netflix viewing data, X (Twitter) likes. The vision model interprets the screen and outputs phone commands. Privacy-preserving: all processing stays local.

**Source:** https://blog.exolabs.net/day-11/

### [Med] EXO SMS AI Assistant — Text Your Local LLM from a Nokia 3310
macOS Messages integration lets EXO act as an SMS AI assistant. Send a text from any phone (including a vintage Nokia 3310), and EXO running locally on your Mac responds via iMessage/SMS. Personal context (calendar, emails, media history) stays on-device.

**Source:** https://blog.exolabs.net/day-6/

### [Med] Llama on Windows 98 — llama98.c
EXO got a 260K-parameter Llama model running on a **Pentium II / Windows 98** machine (borrowed from eBay, £118.88). FTP file transfer, Borland C++ 5.02 compilation, Karpathy's llama2.c as base. Achieved 39.31 tokens/sec on the tiny model. Demonstrates the accessibility mission: "if it runs on 25-year-old hardware, it runs anywhere."

**Source:** https://blog.exolabs.net/day-4/ | **Code:** https://github.com/exo-explore/llama98.c

---

## 🔬 Technical Updates

### [High] Flash Attention Added to Qwen3.5 & Gemma 4 — Major Memory Reduction
PR #1886: Flash Attention to Qwen3.5 and Gemma 4 with RotatingKVCache fix. Results:
- Gemma 4 26B: cache reduced from **54GB → 10GB per 100K tokens**
- Qwen3.5 35B A3B: cache reduced from **21GB → 7GB per 100K tokens**

**Source:** GitHub PR #1886 (rltakashige, April 13)

### [High] KV Prefix Cache Memory Leak Fixed (#1832)
Adam Durham fixed a ~3-4 GB memory leak in KVPrefixCache. Metal buffers were retained until Python GC ran; adding `gc.collect() + mx.clear_cache()` after LRU eviction cut retained memory from 108.88 GB to 105.48 GB (0.38 GB above baseline) on a 2-node PP cluster running Qwen3.5-397B-A17B-4bit at 63K context.

**Source:** GitHub PR #1832 (Adam Durham, April 17)

### [Med] Vision Models Fixed on M5 Pro/Max MacBooks (#1927)
Qwen3-VL tensor parallelism and vision model handling fixed for M5 series. Upstream NAX `addmm` fix (ml-explore/mlx#3422) resolves vision model issues on M5 Max/Pro.

**Source:** GitHub PR #1927 (rltakashige, April 19)

### [Med] Qwen3-VL TP Fix + Auto-Detect Vision Config (#1893)
Qwen3 VL tensor parallelism and vision config auto-detection fixed. Vision capability now properly flagged in model cards.

**Source:** GitHub PR #1893 (rltakashige, April 14)

### [Med] Gemma 4 Tensor Parallelism Added (#1891, #1857)
Gemma 4 model family now supports tensor parallelism. 16 model cards updated to move from `family = "gemma"` → `family = "google"`, with proper Google logo in the dashboard sidebar.

**Source:** GitHub PRs #1891, #1857 (rltakashige, April 14 & 8)

### [Med] Qwen3.6-35B-A3B Model Cards Added (#1907, #1917)
Three new model cards for Qwen3.6-35B-A3B multimodal MoE family (4bit / 5bit / bf16). Vision-capable, 40 layers, 262K context, auto-detected from upstream HF config.

**Source:** GitHub PRs #1907 (Alex Cheema, April 16), #1917 (mlpy0, April 17)

### [Med] mlx CUDA 13 / DGX Spark Support (#1874)
MLX CUDA backend extended to support DGX Spark (MLX CUDA 13), enabling the NVIDIA DGX Spark + Mac Studio hybrid inference described above.

**Source:** GitHub PR #1874 (Evanev7, April 11)

### [Med] RDMA Memory Accounting Fix for Uneven Tensor Parallelism (#1936)
New issue filed: Max available combined RDMA memory needs to account for uneven devices under tensor parallelism. RDMA allocation now correctly handles heterogeneous device memory configurations.

**Source:** GitHub Issue #1936 (leanzero-srl, April 19)

### [Med] Responses API Usage Details Added (#1885)
Responses API now correctly reports `input_tokens_details.cached_tokens` and `output_tokens_details.reasoning_tokens` for both streaming and non-streaming responses.

**Source:** GitHub PR #1885 (ciaranbor, April 13)

### [Med] RKLLM Inference Engine for Rockchip RK3588 (#1879)
New inference engine contributed: RKLLM for Rockchip RK3588 with NPU core pinning. Community contribution expanding hardware support beyond Apple Silicon and NVIDIA.

**Source:** GitHub PR #1879 (jaylfc, April 12)

### [Med] Fallback to HF Mirror for China HF Limitations (#1903)
HF mirror fallback added as mitigation for China-region HuggingFace access limitations.

**Source:** GitHub PR #1903 (rltakashige, April 15)

### [Low] iPad M-Series into the Cluster (#1940)
New issue: user attempting to add M-series iPad into an EXO cluster. Feasibility discussion ongoing.

**Source:** GitHub Issue #1940 (ThatOneGuyGreggers, April 20)

### [Low] Runner Churn Deadlock (#1934)
16 runners stuck (9 ShuttingDown / 6 Ready / 1 Connected), 98 CreateRunner tasks pending — investigation ongoing.

**Source:** GitHub Issue #1934 (lucasajackson, April 19)

---

## 🧪 Research & Innovation (12 Days of EXO)

### [High] SPARTA — Sparse Parameter Averaging for 1000× Bandwidth Reduction
Day 12's landmark result: **SPARTA** enables distributed training with 1,000× less communication than full synchronization. Only 0.1% of model parameters exchanged per step. Works fully asynchronously (params can be up to 15 steps stale with no degradation). Combined with DiLoCo (H averaging every 20 steps) achieves 4,000×+ reduction. Can scale to 48 Mac Minis. Led by Matthew Reed and Mohamed Baioumy.

**Source:** https://blog.exolabs.net/day-12/

### [High] EXO Private Search — Homomorphic Encryption + Tiptoe
Privacy-preserving search: query encrypted client-side via Paillier homomorphic encryption; server processes inner products without seeing query. Optimized with Tiptoe cluster selection (√N centroids locally, then SimplePIR for private document retrieval). 5,000× reduction in vectors to compare. Full implementation open-source at github.com/exo-explore/private-search, integrated into EXO Desktop App (v0.0.3-alpha).

**Source:** https://blog.exolabs.net/day-8/ | **Code:** https://github.com/exo-explore/private-search

### [High] evML — Edge-Verified Machine Learning (5% overhead)
Verifiable distributed training using device Secure Contexts (TEE/SC-based attestation via DeviceAttest on Apple, Play Integrity on Android). 5% verification overhead. Eliminates need for staking or special hardware. Preliminary report: https://github.com/exo-explore/evML

**Source:** https://blog.exolabs.net/day-10/

### [High] EXO Gym — Distributed Training Research Toolkit
Simulator for DiLoCo, SPARTA, and other distributed training algorithms — runs on a single machine. First competition: train nanoGPT 124M on 4 simulated nodes. Scaling targets: 8× M4 MacMinis (TB5) for medium-scale, distributed datacenter for 7B+.

**Source:** https://blog.exolabs.net/day-9/ | **Code:** https://github.com/exo-explore/gym | **Competition:** https://forms.gle/FcyDDQSBN6bqfrATA

### [Med] DiLoCo Training Over Internet — 100-1000× Bandwidth Reduction
Day 5: Explored DiLoCo (Distributed Low-Communication training) enabling training over slow internet by synchronizing only every H steps. With H=500, 2 GPUs over home internet matches datacenter performance (8.7 hours vs. 7.3 days naively).

**Source:** https://blog.exolabs.net/day-5/

### [Med] License Change Coming in Early 2025
Day 7 announced: EXO moving to a more open license in early 2025, aligned with core belief that AI infrastructure should be truly open. Contributors contacted via Discord #license channel.

**Source:** https://blog.exolabs.net/day-7/

---

## 💬 Community Pulse

### Hacker News
- **61 points** — "Nvidia DGX Spark and Apple Mac Studio = 4x Faster LLM Inference with EXO 1.0" (April 2026) — Comments discuss the heterogeneous compute scheduling, KV streaming overlap math, and hardware implications.
- Classic HN skepticism thread (2024): "Exo: Run your own AI cluster at home with everyday devices" — question about Apple Silicon-only mlx on non-Apple hardware. EXO's answer: NVIDIA and other backends are in progress.

**Source:** https://news.ycombinator.com/item?id=45611912 | https://news.ycombinator.com/item?id=40973339

### Reddit r/LocalLLaMA & r/LocalLLM
- **OpenClaw on Mac + EXO issues** — French user having EXO crash issues with OpenClaw local; LM Studio as alternative.
- **Mac Studio M3 Ultra 96GB multi-model setup** — Discussion of OpenClaw + EXO as local assistant with RAG, coding, Korean↔English tasks.
- **oMLX SSD KV caching for Apple Silicon** — OpenClaw-specific optimization thread.

**Source:** https://reddit.com/r/LocalLLaMA | https://reddit.com/r/LocalLLM

### Discord
Active community with channels for: retro hardware experiments (#retro — Windows 98, Gameboy, etc.), research (DiLoCo, SPARTA, evML), hardware sharing, and licensing discussion.

**Join:** https://discord.gg/EUnjGpsmWw

---

## 📰 Market Signals

### Third-Party Coverage
- **ToolHalla** — "EXO Framework: Run 70B+ Models Across Multiple GPUs (2026 Guide)" — Practical guide covering cluster setup, model selection, performance optimization.
- **Virge.io** — "exo: run 671B parameter models on a cluster of Mac Studios" — Deep dive into the DeepSeek V3 Mac Studio cluster results.
- **Petronella Tech** — "MLX + Exo: Run LLMs on Apple Silicon (2026 Guide)"
- **Medium** — Akshat Laddha: "Self Hosting Llama-70B on Apple Silicon with Exo and MLX"

### GitHub Growth
43,261 stars, 2,983 forks. The "12 Days of EXO" campaign generated significant visibility; stars grew substantially during the campaign period.

---

## 📊 Open PRs Worth Watching

| PR | Title | Author | Status |
|----|-------|--------|--------|
| #1938 | fix(download): treat HF size=None as "size unknown, trust filesystem" | nhwaani | Open |
| #1935 | fix: per-model sampling defaults to prevent MiniMax repetition loops | qtkt2hmr2v-debug | Open |
| #1925 | feat(dashboard): add Pi integration tab | nhwaani | Open |
| #1905 | Extend bench/eval tooling | ciaranbor | Open |
| #1879 | RKLLM inference engine with NPU core pinning for Rockchip RK3588 | jaylfc | Open |
| #1874 | mlx cuda 13 (dgx spark) support | Evanev7 | Open |

---

## 🐛 Notable Open Issues

| Issue | Title | Author | Comments |
|-------|-------|--------|----------|
| #1940 | m-series iPad into the cluster | ThatOneGuyGreggers | 0 |
| #1939 | [CRITICAL] MiniMax-M2.7 causes kernel panic on M3 Ultra 512GB | qtkt2hmr2v-debug | 0 |
| #1937 | place_instance silently fails for qwen3_moe architecture | nhwaani | 1 |
| #1934 | Runner churn deadlock: 16 runners stuck | lucasajackson | 0 |
| #1928 | Kimi K2.5 vision fails with TypeError in projector | bennysigs | 1 |
| #1922 | Gemma 4 31b 8bit always looping | leanzero-srl | 3 |

---

## 🔮 Trends & Takeaways

1. **MoE Dominance**: DeepSeek V3 671B running at 5.37 TPS on consumer Mac Minis proves MoE is the key to making frontier models accessible. Expect more MoE model support.
2. **Heterogeneous Compute**: The DGX Spark + Mac Studio hybrid prefill/decode disaggregation signals a trend toward specialized role assignment in clusters.
3. **Privacy as Differentiator**: Private search (homomorphic encryption + Tiptoe) and evML show EXO is building a full privacy stack, not just inference.
4. **Research Velocity**: The 12 Days campaign demonstrates exceptional output — SPARTA, evML, EXO Gym, private search, and SMS integration all within 12 days.
5. **License Opening**: The upcoming license change (early 2025) could be a significant community catalyst.
6. **Memory Optimization Focus**: Multiple PRs (#1886 memory reduction, #1832 leak fix, #1888 prefix cache in bench) indicate memory is a primary engineering frontier as context lengths grow.

---

## 🔗 Quick Links

- **GitHub:** https://github.com/exo-explore/exo (43K stars)
- **Blog:** https://blog.exolabs.net/
- **Benchmarks:** https://benchmarks.exolabs.net/
- **Discord:** https://discord.gg/EUnjGpsmWw
- **Private Search:** https://github.com/exo-explore/private-search
- **EXO Gym:** https://github.com/exo-explore/gym
- **evML:** https://github.com/exo-explore/evML
- **llama98.c:** https://github.com/exo-explore/llama98.c

---

*Compiled by Cilla | EXO Labs Daily Briefing | 2026-04-20*
