# Data sampling algorithms Schema

```txt
http://github.com/felixleopoldo/benchpress/schema/config.schema.json#/properties/resources/properties/data
```

Data sampling setup.

| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                    |
| :------------------ | :--------- | :------------- | :----------- | :---------------- | :-------------------- | :------------------ | :---------------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Forbidden             | none                | [config.schema.json*](../../../out/config.schema.json "open original schema") |

## data Type

`object` ([Data sampling algorithms](config-properties-resources-properties-data-sampling-algorithms.md))

# Data sampling algorithms Properties

| Property    | Type    | Required | Nullable       | Defined by                                                                                                                                                                                                                                                              |
| :---------- | :------ | :------- | :------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [iid](#iid) | `array` | Optional | cannot be null | [JSON schema for BenchPress config file.](config-properties-resources-properties-data-sampling-algorithms-properties-list-of-iid-setups.md "http://github.com/felixleopoldo/benchpress/schema/config.schema.json#/properties/resources/properties/data/properties/iid") |

## iid

List of iid setups.

`iid`

*   is optional

*   Type: `object[]` ([Standard sampling](config-definitions-standard-sampling.md))

*   cannot be null

*   defined in: [JSON schema for BenchPress config file.](config-properties-resources-properties-data-sampling-algorithms-properties-list-of-iid-setups.md "http://github.com/felixleopoldo/benchpress/schema/config.schema.json#/properties/resources/properties/data/properties/iid")

### iid Type

`object[]` ([Standard sampling](config-definitions-standard-sampling.md))

### iid Constraints

**unique items**: all items in this array must be unique. Duplicates are not allowed.
