;; ArtProvenance: Fine Art Authentication and Provenance Platform
;; Version: 1.0.0
(define-constant ERR-NOT-AUTHORIZED (err u1))
(define-constant ERR-ARTWORK-NOT-FOUND (err u2))
(define-constant ERR-ALREADY-CATALOGUED (err u3))
(define-constant ERR-INVALID-STATUS (err u4))
(define-constant ERR-INVALID-CREATION-YEAR (err u5))
(define-constant ERR-INVALID-MEDIUM (err u6))
(define-constant ERR-INVALID-AUTHENTICITY (err u7))
(define-constant ERR-INVALID-ARTWORK-TITLE (err u8))
(define-constant ERR-INVALID-ATTRIBUTION (err u9))
(define-constant MIN-CREATION-YEAR u1400)
(define-data-var next-artwork-id uint u1)
(define-map fine-artworks
    uint
    {
        curator: principal,
        artwork-title: (string-utf8 50),
        attribution: (string-utf8 200),
        medium: (string-utf8 15),
        authenticity: (string-utf8 15),
        exhibition-status: (string-utf8 10),
        creation-year: uint
    }
)
(define-private (validate-medium (medium (string-utf8 15)))
    (or 
        (is-eq medium u"Oil Painting")
        (is-eq medium u"Watercolor")
        (is-eq medium u"Sculpture")
        (is-eq medium u"Drawing")
        (is-eq medium u"Print")
        (is-eq medium u"Mixed Media")
    )
)
(define-private (validate-authenticity (authenticity (string-utf8 15)))
    (or 
        (is-eq authenticity u"Authenticated")
        (is-eq authenticity u"Attributed")
        (is-eq authenticity u"School of")
        (is-eq authenticity u"After")
        (is-eq authenticity u"Unverified")
    )
)
(define-private (validate-text-format (text (string-utf8 200)) (min-length uint) (max-length uint))
    (let 
        (
            (text-length (len text))
        )
        (and 
            (>= text-length min-length)
            (<= text-length max-length)
        )
    )
)
(define-public (catalogue-artwork 
    (artwork-title (string-utf8 50))
    (attribution (string-utf8 200))
    (medium (string-utf8 15))
    (authenticity (string-utf8 15))
    (creation-year uint)
)
    (let
        (
            (artwork-id (var-get next-artwork-id))
        )
        (asserts! (validate-text-format artwork-title u3 u50) ERR-INVALID-ARTWORK-TITLE)
        (asserts! (validate-text-format attribution u10 u200) ERR-INVALID-ATTRIBUTION)
        (asserts! (>= creation-year MIN-CREATION-YEAR) ERR-INVALID-CREATION-YEAR)
        (asserts! (validate-medium medium) ERR-INVALID-MEDIUM)
        (asserts! (validate-authenticity authenticity) ERR-INVALID-AUTHENTICITY)
        
        (map-set fine-artworks artwork-id {
            curator: tx-sender,
            artwork-title: artwork-title,
            attribution: attribution,
            medium: medium,
            authenticity: authenticity,
            exhibition-status: u"catalogued",
            creation-year: creation-year
        })
        (var-set next-artwork-id (+ artwork-id u1))
        (ok artwork-id)
    )
)
(define-public (deaccession-artwork (artwork-id uint))
    (let
        (
            (artwork (unwrap! (map-get? fine-artworks artwork-id) ERR-ARTWORK-NOT-FOUND))
        )
        (asserts! (is-eq tx-sender (get curator artwork)) ERR-NOT-AUTHORIZED)
        (asserts! (is-eq (get exhibition-status artwork) u"catalogued") ERR-INVALID-STATUS)
        (ok (map-set fine-artworks artwork-id (merge artwork { exhibition-status: u"deaccessioned" })))
    )
)
(define-read-only (get-artwork (artwork-id uint))
    (ok (map-get? fine-artworks artwork-id))
)
(define-read-only (get-curator (artwork-id uint))
    (ok (get curator (unwrap! (map-get? fine-artworks artwork-id) ERR-ARTWORK-NOT-FOUND)))
)