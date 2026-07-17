# データモデル設計

## エンティティ関係

```
CATEGORY ──< TRANSACTION >── CLIENT
 (必須FK)                    (任意FK)
```

`TRANSACTION` から2本の外部キーが伸びる構成がポイント。

## モデル一覧

### 1. Category（科目）
| フィールド | 型 | 備考 |
|---|---|---|
| name | CharField | 科目名 |
| type | choices | 「売上」/「経費」の2択 |

科目名は確定申告の勘定科目に寄せる（実用性のため）。
- 売上: 業務委託、保守運用
- 経費: 旅費交通費、通信費、消耗品費、外注工賃、地代家賃

※ アプリ内の分類設計であり、実際の申告区分そのものではない。

### 2. Client(取引先・案件)
| フィールド | 型 | 備考 |
|---|---|---|
| name | CharField | 取引先名・案件名 |

### 3. Transaction（取引）
| フィールド | 型 | 備考 |
|---|---|---|
| date | DateField | 取引日 |
| amount | 金額 | |
| category | ForeignKey(Category) | **必須** |
| client | ForeignKey(Client) | **任意**（`null=True, blank=True`） |
| memo など | 任意 | |

## 設計の考え方
- 売上には「どのクライアントからか」が付くが、通信費・消耗品費などの経費は特定の取引先に紐づかないことが多い → Client は任意の関連にする
- 「あってもなくてもいい関連」を `null=True, blank=True` で表現し、必須の関連との違いを学ぶ

## 実装順序の選択肢
1. **最初から3モデル**（Category + Transaction + Client）
2. **まず2モデル**（家計簿版と同じ Category + Transaction）で組み、Client は Phase 5 前後で追加

欲張らず 2 → 3 の順で進める選択肢もあり。どちらでも骨格は同じ。
