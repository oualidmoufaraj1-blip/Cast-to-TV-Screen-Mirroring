/// Global ads state. Ads SDK is not initialized; [gAdsReady] stays false so
/// any legacy callers treat ads as unavailable without branching on review.
bool gAdsReady = false;
