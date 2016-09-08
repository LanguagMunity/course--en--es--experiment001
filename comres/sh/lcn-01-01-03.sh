


#languamunity agri -ft "${LANGDRILL_X_SCRAT}/x.json" -f "${LANGDRILL_X_LCDIR}/01-01-tx.json" -lm 30
#languamunity agri -ft "${LANGDRILL_X_SCRAT}/x.json" -f "${LANGDRILL_X_LCDIR}/01-02-tx.json" -lm 45
sh "${LANGDRILL_X_SCRAT}/post-01-01-02.sh"

languamunity qsp-take -to "${LANGDRILL_X_QUIZ_FILE}" -in "${LANGDRILL_X_SCRAT}/x.json"
languamunity qsp-take -to "${LANGDRILL_X_QUIZ_FILE}" -in "${LANGDRILL_X_LCDIR}/01-03-tx.json"

