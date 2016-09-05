


#languamunity agri -ft "${LANGDRILL_X_SCRAT}/x.json" -f "${LANGDRILL_X_LCDIR}/01-01-tx.json" -lm 30
#languamunity agri -ft "${LANGDRILL_X_SCRAT}/x.json" -f "${LANGDRILL_X_LCDIR}/01-02-tx.json" -lm 45
sh "${LANGDRILL_X_SCRAT}/post-01-01-02.sh"

languamunity lc-take "${LANGDRILL_X_SCRAT}/x.json"
languamunity lc-take "${LANGDRILL_X_LCDIR}/01-03-tx.json"

