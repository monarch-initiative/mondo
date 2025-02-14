from __future__ import annotations
from datetime import datetime, date
from enum import Enum
from typing import List, Dict, Optional, Any, Union
from pydantic import BaseModel as BaseModel, ConfigDict, Field
import sys
if sys.version_info >= (3, 8):
    from typing import Literal
else:
    from typing_extensions import Literal


metamodel_version = "None"
version = "None"

class WeakRefShimBaseModel(BaseModel):
   __slots__ = '__weakref__'

class ConfiguredBaseModel(WeakRefShimBaseModel,
                validate_assignment = True,
                validate_all = True,
                underscore_attrs_are_private = True,
                extra = 'forbid',
                arbitrary_types_allowed = True,
                use_enum_values = True):
    pass


class EntityTypeEnum(str, Enum):
    
    
    owl_class = "owl class"
    
    owl_object_property = "owl object property"
    
    owl_data_property = "owl data property"
    
    owl_annotation_property = "owl annotation property"
    
    owl_named_individual = "owl named individual"
    
    skos_concept = "skos concept"
    
    rdfs_resource = "rdfs resource"
    
    rdfs_class = "rdfs class"
    
    rdfs_literal = "rdfs literal"
    
    rdfs_datatype = "rdfs datatype"
    
    rdf_property = "rdf property"
    
    

class PredicateModifierEnum(str, Enum):
    
    # Negating the mapping predicate. The meaning of the triple becomes subject_id is not a predicate_id match to object_id.
    Not = "Not"
    
    

class MappingCardinalityEnum(str, Enum):
    
    # One-to-one mapping
    number_1COLON1 = "1:1"
    # One-to-many mapping
    number_1COLONn = "1:n"
    # Many-to-one mapping
    nCOLON1 = "n:1"
    # One-to-none mapping
    number_1COLON0 = "1:0"
    # None-to-one mapping
    number_0COLON1 = "0:1"
    # Many-to-many mapping
    nCOLONn = "n:n"
    
    

class MappingSet(ConfiguredBaseModel):
    """
    Represents a set of mappings
    """
    curie_map: Optional[Dict[str, Prefix]] = Field(default_factory=dict, description="""A dictionary that contains prefixes as keys and their URI expansions as values.""")
    mappings: Optional[List[Mapping]] = Field(default_factory=list, description="""Contains a list of mapping objects""")
    mapping_set_id: str = Field(..., description="""A globally unique identifier for the mapping set (not each individual mapping). Should be IRI, ideally resolvable.""")
    mapping_set_version: Optional[str] = Field(None, description="""A version string for the mapping.""")
    mapping_set_source: Optional[List[str]] = Field(default_factory=list, description="""A mapping set or set of mapping set that was used to derive the mapping set.""")
    mapping_set_title: Optional[str] = Field(None, description="""The display name of a mapping set.""")
    mapping_set_description: Optional[str] = Field(None, description="""A description of the mapping set.""")
    creator_id: Optional[List[str]] = Field(default_factory=list, description="""Identifies the persons or groups responsible for the creation of the mapping. The creator is the agent that put the mapping in its published form, which may be different from the author, which is a person that was actively involved in the assertion of the mapping. Recommended to be a list of ORCIDs or otherwise identifying URIs.""")
    creator_label: Optional[List[str]] = Field(default_factory=list, description="""A string identifying the creator of this mapping. In the spirit of provenance, consider using creator_id instead.""")
    license: str = Field(..., description="""A url to the license of the mapping. In absence of a license we assume no license.""")
    subject_type: Optional[EntityTypeEnum] = Field(None, description="""The type of entity that is being mapped.""")
    subject_source: Optional[str] = Field(None, description="""URI of vocabulary or identifier source for the subject.""")
    subject_source_version: Optional[str] = Field(None, description="""Version IRI or version string of the source of the subject term.""")
    object_type: Optional[EntityTypeEnum] = Field(None, description="""The type of entity that is being mapped.""")
    object_source: Optional[str] = Field(None, description="""URI of vocabulary or identifier source for the object.""")
    object_source_version: Optional[str] = Field(None, description="""Version IRI or version string of the source of the object term.""")
    mapping_provider: Optional[str] = Field(None, description="""URL pointing to the source that provided the mapping, for example an ontology that already contains the mappings, or a database from which it was derived.""")
    mapping_tool: Optional[str] = Field(None, description="""A reference to the tool or algorithm that was used to generate the mapping. Should be a URL pointing to more info about it, but can be free text.""")
    mapping_tool_version: Optional[str] = Field(None, description="""Version string that denotes the version of the mapping tool used.""")
    mapping_date: Optional[date] = Field(None, description="""The date the mapping was asserted. This is different from the date the mapping was published or compiled in a SSSOM file.""")
    publication_date: Optional[date] = Field(None, description="""The date the mapping was published. This is different from the date the mapping was asserted.""")
    subject_match_field: Optional[List[str]] = Field(default_factory=list, description="""A list of properties (term annotations on the subject) that was used for the match.""")
    object_match_field: Optional[List[str]] = Field(default_factory=list, description="""A list of properties (term annotations on the object) that was used for the match.""")
    subject_preprocessing: Optional[List[str]] = Field(default_factory=list, description="""Method of preprocessing applied to the fields of the subject. If different preprocessing steps were performed on different fields, it is recommended to store the match in separate rows.""")
    object_preprocessing: Optional[List[str]] = Field(default_factory=list, description="""Method of preprocessing applied to the fields of the object. If different preprocessing steps were performed on different fields, it is recommended to store the match in separate rows.""")
    see_also: Optional[List[str]] = Field(default_factory=list, description="""A URL specific for the mapping instance. E.g. for kboom we have a per-mapping image that shows surrounding axioms that drive probability. Could also be a github issue URL that discussed a complicated alignment""")
    issue_tracker: Optional[str] = Field(None, description="""A URL location of the issue tracker for this entity.""")
    other: Optional[str] = Field(None, description="""Pipe separated list of key value pairs for properties not part of the SSSOM spec. Can be used to encode additional provenance data.""")
    comment: Optional[str] = Field(None, description="""Free text field containing either curator notes or text generated by tool providing additional informative information.""")
    

class Mapping(ConfiguredBaseModel):
    """
    Represents an individual mapping between a pair of entities
    """
    subject_id: str = Field(..., description="""The ID of the subject of the mapping.""")
    subject_label: Optional[str] = Field(None, description="""The label of subject of the mapping""")
    subject_category: Optional[str] = Field(None, description="""The conceptual category to which the subject belongs to. This can be a string denoting the category or a term from a controlled vocabulary. This slot is deliberately underspecified. Conceptual categories can range from those that are found in general upper ontologies such as BFO (e.g. process, temporal region, etc) to those that serve as upper ontologies in specific domains, such as COB or BioLink (e.g. gene, disease, chemical entity). The purpose of this optional field is documentation for human reviewers - when a category is known and documented clearly, the cost of interpreting and evaluating the mapping decreases.""")
    predicate_id: str = Field(..., description="""The ID of the predicate or relation that relates the subject and object of this match.""")
    predicate_label: Optional[str] = Field(None, description="""The label of the predicate/relation of the mapping""")
    predicate_modifier: Optional[PredicateModifierEnum] = Field(None, description="""A modifier for negating the prediate. See https://github.com/mapping-commons/sssom/issues/40 for discussion""")
    object_id: str = Field(..., description="""The ID of the object of the mapping.""")
    object_label: Optional[str] = Field(None, description="""The label of object of the mapping""")
    object_category: Optional[str] = Field(None, description="""The conceptual category to which the subject belongs to. This can be a string denoting the category or a term from a controlled vocabulary. This slot is deliberately underspecified. Conceptual categories can range from those that are found in general upper ontologies such as BFO (e.g. process, temporal region, etc) to those that serve as upper ontologies in specific domains, such as COB or BioLink (e.g. gene, disease, chemical entity). The purpose of this optional field is documentation for human reviewers - when a category is known and documented clearly, the cost of interpreting and evaluating the mapping decreases.""")
    mapping_justification: str = Field(..., description="""A mapping justification is an action (or the written representation of that action) of showing a mapping to be right or reasonable.""")
    author_id: Optional[List[str]] = Field(default_factory=list, description="""Identifies the persons or groups responsible for asserting the mappings. Recommended to be a list of ORCIDs or otherwise identifying URIs.""")
    author_label: Optional[List[str]] = Field(default_factory=list, description="""A string identifying the author of this mapping. In the spirit of provenance, consider using author_id instead.""")
    reviewer_id: Optional[List[str]] = Field(default_factory=list, description="""Identifies the persons or groups that reviewed and confirmed the mapping. Recommended to be a list of ORCIDs or otherwise identifying URIs.""")
    reviewer_label: Optional[List[str]] = Field(default_factory=list, description="""A string identifying the reviewer of this mapping. In the spirit of provenance, consider using reviewer_id instead.""")
    creator_id: Optional[List[str]] = Field(default_factory=list, description="""Identifies the persons or groups responsible for the creation of the mapping. The creator is the agent that put the mapping in its published form, which may be different from the author, which is a person that was actively involved in the assertion of the mapping. Recommended to be a list of ORCIDs or otherwise identifying URIs.""")
    creator_label: Optional[List[str]] = Field(default_factory=list, description="""A string identifying the creator of this mapping. In the spirit of provenance, consider using creator_id instead.""")
    license: Optional[str] = Field(None, description="""A url to the license of the mapping. In absence of a license we assume no license.""")
    subject_type: Optional[EntityTypeEnum] = Field(None, description="""The type of entity that is being mapped.""")
    subject_source: Optional[str] = Field(None, description="""URI of vocabulary or identifier source for the subject.""")
    subject_source_version: Optional[str] = Field(None, description="""Version IRI or version string of the source of the subject term.""")
    object_type: Optional[EntityTypeEnum] = Field(None, description="""The type of entity that is being mapped.""")
    object_source: Optional[str] = Field(None, description="""URI of vocabulary or identifier source for the object.""")
    object_source_version: Optional[str] = Field(None, description="""Version IRI or version string of the source of the object term.""")
    mapping_provider: Optional[str] = Field(None, description="""URL pointing to the source that provided the mapping, for example an ontology that already contains the mappings, or a database from which it was derived.""")
    mapping_source: Optional[str] = Field(None, description="""The mapping set this mapping was originally defined in. mapping_source is used for example when merging multiple mapping sets or deriving one mapping set from another.""")
    mapping_cardinality: Optional[MappingCardinalityEnum] = Field(None, description="""A string indicating whether this mapping is from a 1:1 (the subject_id maps to a single object_id), 1:n (the subject maps to more than one object_id), n:1, 1:0, 0:1 or n:n group. Note that this is a convenience field that should be derivable from the mapping set.""")
    mapping_tool: Optional[str] = Field(None, description="""A reference to the tool or algorithm that was used to generate the mapping. Should be a URL pointing to more info about it, but can be free text.""")
    mapping_tool_version: Optional[str] = Field(None, description="""Version string that denotes the version of the mapping tool used.""")
    mapping_date: Optional[date] = Field(None, description="""The date the mapping was asserted. This is different from the date the mapping was published or compiled in a SSSOM file.""")
    publication_date: Optional[date] = Field(None, description="""The date the mapping was published. This is different from the date the mapping was asserted.""")
    confidence: Optional[float] = Field(None, description="""A score between 0 and 1 to denote the confidence or probability that the match is correct, where 1 denotes total confidence.""")
    curation_rule: Optional[List[str]] = Field(default_factory=list, description="""A curation rule is a (potentially) complex condition executed by an agent that led to the establishment of a mapping. Curation rules often involve complex domain-specific considerations, which are hard to capture in an automated fashion. The curation rule is captured as a resource rather than a string, which enables higher levels of transparency and sharing across mapping sets. The URI representation of the curation rule is expected to be a resolvable identifier which provides details about the nature of the curation rule.""")
    curation_rule_text: Optional[List[str]] = Field(default_factory=list, description="""A curation rule is a (potentially) complex condition executed by an agent that led to the establishment of a mapping. Curation rules often involve complex domain-specific considerations, which are hard to capture in an automated fashion. The curation rule should be captured as a resource (entity reference) rather than a string (see curation_rule element), which enables higher levels of transparency and sharing across mapping sets. The textual representation of curation rule is intended to be used in cases where (1) the creation of a resource is not practical from the perspective of the mapping_provider and (2) as an additional piece of metadata to augment the curation_rule element with a human readable text.""")
    subject_match_field: Optional[List[str]] = Field(default_factory=list, description="""A list of properties (term annotations on the subject) that was used for the match.""")
    object_match_field: Optional[List[str]] = Field(default_factory=list, description="""A list of properties (term annotations on the object) that was used for the match.""")
    match_string: Optional[List[str]] = Field(default_factory=list, description="""String that is shared by subj/obj. It is recommended to indicate the fields for the match using the object and subject_match_field slots.""")
    subject_preprocessing: Optional[List[str]] = Field(default_factory=list, description="""Method of preprocessing applied to the fields of the subject. If different preprocessing steps were performed on different fields, it is recommended to store the match in separate rows.""")
    object_preprocessing: Optional[List[str]] = Field(default_factory=list, description="""Method of preprocessing applied to the fields of the object. If different preprocessing steps were performed on different fields, it is recommended to store the match in separate rows.""")
    semantic_similarity_score: Optional[float] = Field(None, description="""A score between 0 and 1 to denote the semantic similarity, where 1 denotes equivalence.""")
    semantic_similarity_measure: Optional[str] = Field(None, description="""The measure used for computing the the semantic similarity score. To make processing this field as unambiguous as possible, we recommend using wikidata identifiers, but wikipedia pages could also be acceptable.""")
    see_also: Optional[List[str]] = Field(default_factory=list, description="""A URL specific for the mapping instance. E.g. for kboom we have a per-mapping image that shows surrounding axioms that drive probability. Could also be a github issue URL that discussed a complicated alignment""")
    issue_tracker_item: Optional[str] = Field(None, description="""The issue tracker item discussing this mapping.""")
    other: Optional[str] = Field(None, description="""Pipe separated list of key value pairs for properties not part of the SSSOM spec. Can be used to encode additional provenance data.""")
    comment: Optional[str] = Field(None, description="""Free text field containing either curator notes or text generated by tool providing additional informative information.""")
    

class LiteralMapping(ConfiguredBaseModel):
    """
    Represents an individual mapping between a literal and an entity. Note that this schema has been created on 01.08.2023 and is subject to change.
    """
    literal: str = Field(..., description="""The literal being mapped""")
    literal_datatype: Optional[str] = Field(None, description="""The datatype of the literal being mapped""")
    predicate_id: str = Field(..., description="""The ID of the predicate or relation that relates the subject and object of this match.""")
    predicate_label: Optional[str] = Field(None, description="""The label of the predicate/relation of the mapping""")
    predicate_modifier: Optional[PredicateModifierEnum] = Field(None, description="""A modifier for negating the prediate. See https://github.com/mapping-commons/sssom/issues/40 for discussion""")
    object_id: str = Field(..., description="""The ID of the object of the mapping.""")
    object_label: Optional[str] = Field(None, description="""The label of object of the mapping""")
    object_category: Optional[str] = Field(None, description="""The conceptual category to which the subject belongs to. This can be a string denoting the category or a term from a controlled vocabulary. This slot is deliberately underspecified. Conceptual categories can range from those that are found in general upper ontologies such as BFO (e.g. process, temporal region, etc) to those that serve as upper ontologies in specific domains, such as COB or BioLink (e.g. gene, disease, chemical entity). The purpose of this optional field is documentation for human reviewers - when a category is known and documented clearly, the cost of interpreting and evaluating the mapping decreases.""")
    mapping_justification: str = Field(..., description="""A mapping justification is an action (or the written representation of that action) of showing a mapping to be right or reasonable.""")
    author_id: Optional[List[str]] = Field(default_factory=list, description="""Identifies the persons or groups responsible for asserting the mappings. Recommended to be a list of ORCIDs or otherwise identifying URIs.""")
    author_label: Optional[List[str]] = Field(default_factory=list, description="""A string identifying the author of this mapping. In the spirit of provenance, consider using author_id instead.""")
    reviewer_id: Optional[List[str]] = Field(default_factory=list, description="""Identifies the persons or groups that reviewed and confirmed the mapping. Recommended to be a list of ORCIDs or otherwise identifying URIs.""")
    reviewer_label: Optional[List[str]] = Field(default_factory=list, description="""A string identifying the reviewer of this mapping. In the spirit of provenance, consider using reviewer_id instead.""")
    creator_id: Optional[List[str]] = Field(default_factory=list, description="""Identifies the persons or groups responsible for the creation of the mapping. The creator is the agent that put the mapping in its published form, which may be different from the author, which is a person that was actively involved in the assertion of the mapping. Recommended to be a list of ORCIDs or otherwise identifying URIs.""")
    creator_label: Optional[List[str]] = Field(default_factory=list, description="""A string identifying the creator of this mapping. In the spirit of provenance, consider using creator_id instead.""")
    license: Optional[str] = Field(None, description="""A url to the license of the mapping. In absence of a license we assume no license.""")
    literal_source: Optional[str] = Field(None, description="""URI of ontology source for the literal.""")
    literal_source_version: Optional[str] = Field(None, description="""Version IRI or version string of the source of the literal.""")
    object_type: Optional[EntityTypeEnum] = Field(None, description="""The type of entity that is being mapped.""")
    object_source: Optional[str] = Field(None, description="""URI of vocabulary or identifier source for the object.""")
    object_source_version: Optional[str] = Field(None, description="""Version IRI or version string of the source of the object term.""")
    mapping_provider: Optional[str] = Field(None, description="""URL pointing to the source that provided the mapping, for example an ontology that already contains the mappings, or a database from which it was derived.""")
    mapping_source: Optional[str] = Field(None, description="""The mapping set this mapping was originally defined in. mapping_source is used for example when merging multiple mapping sets or deriving one mapping set from another.""")
    mapping_cardinality: Optional[MappingCardinalityEnum] = Field(None, description="""A string indicating whether this mapping is from a 1:1 (the subject_id maps to a single object_id), 1:n (the subject maps to more than one object_id), n:1, 1:0, 0:1 or n:n group. Note that this is a convenience field that should be derivable from the mapping set.""")
    mapping_tool: Optional[str] = Field(None, description="""A reference to the tool or algorithm that was used to generate the mapping. Should be a URL pointing to more info about it, but can be free text.""")
    mapping_tool_version: Optional[str] = Field(None, description="""Version string that denotes the version of the mapping tool used.""")
    mapping_date: Optional[date] = Field(None, description="""The date the mapping was asserted. This is different from the date the mapping was published or compiled in a SSSOM file.""")
    confidence: Optional[float] = Field(None, description="""A score between 0 and 1 to denote the confidence or probability that the match is correct, where 1 denotes total confidence.""")
    object_match_field: Optional[List[str]] = Field(default_factory=list, description="""A list of properties (term annotations on the object) that was used for the match.""")
    match_string: Optional[List[str]] = Field(default_factory=list, description="""String that is shared by subj/obj. It is recommended to indicate the fields for the match using the object and subject_match_field slots.""")
    literal_preprocessing: Optional[List[str]] = Field(default_factory=list, description="""Method of preprocessing applied to the literal.""")
    object_preprocessing: Optional[List[str]] = Field(default_factory=list, description="""Method of preprocessing applied to the fields of the object. If different preprocessing steps were performed on different fields, it is recommended to store the match in separate rows.""")
    similarity_score: Optional[float] = Field(None, description="""A score between 0 and 1 to denote the similarity, where 1 denotes equivalence.""")
    similarity_measure: Optional[str] = Field(None, description="""The measure used for computing the the similarity score. To make processing this field as unambiguous as possible, we recommend using wikidata identifiers, but wikipedia pages could also be acceptable.""")
    see_also: Optional[List[str]] = Field(default_factory=list, description="""A URL specific for the mapping instance. E.g. for kboom we have a per-mapping image that shows surrounding axioms that drive probability. Could also be a github issue URL that discussed a complicated alignment""")
    other: Optional[str] = Field(None, description="""Pipe separated list of key value pairs for properties not part of the SSSOM spec. Can be used to encode additional provenance data.""")
    comment: Optional[str] = Field(None, description="""Free text field containing either curator notes or text generated by tool providing additional informative information.""")
    

class MappingRegistry(ConfiguredBaseModel):
    """
    A registry for managing mapping sets. It holds a set of mapping set references, and can import other registries.
    """
    mapping_registry_id: str = Field(..., description="""The unique identifier of a mapping registry.""")
    mapping_registry_title: Optional[str] = Field(None, description="""The title of a mapping registry.""")
    mapping_registry_description: Optional[str] = Field(None, description="""The description of a mapping registry.""")
    imports: Optional[List[str]] = Field(default_factory=list, description="""A list of registries that should be imported into this one.""")
    mapping_set_references: Optional[List[MappingSetReference]] = Field(default_factory=list, description="""A list of mapping set references.""")
    documentation: Optional[str] = Field(None, description="""A URL to the documentation of this mapping commons.""")
    homepage: Optional[str] = Field(None, description="""A URL to a homepage of this mapping commons.""")
    issue_tracker: Optional[str] = Field(None, description="""A URL location of the issue tracker for this entity.""")
    

class MappingSetReference(ConfiguredBaseModel):
    """
    A reference to a mapping set. It allows to augment mapping set metadata from the perspective of the registry, for example, providing confidence, or a local filename or a grouping.
    """
    mapping_set_id: str = Field(..., description="""A globally unique identifier for the mapping set (not each individual mapping). Should be IRI, ideally resolvable.""")
    mirror_from: Optional[str] = Field(None, description="""A URL location from which to obtain a resource, such as a mapping set.""")
    registry_confidence: Optional[float] = Field(None, description="""This value is set by the registry that indexes the mapping set. It reflects the confidence the registry has in the correctness of the mappings in the mapping set.""")
    mapping_set_group: Optional[str] = Field(None, description="""Set by the owners of the mapping registry. A way to group .""")
    last_updated: Optional[date] = Field(None, description="""The date this reference was last updated.""")
    local_name: Optional[str] = Field(None, description="""The local name assigned to file that corresponds to the downloaded mapping set.""")
    

class Prefix(ConfiguredBaseModel):
    
    prefix_name: str = Field(...)
    prefix_url: Optional[str] = Field(None)
    


# Update forward refs
# see https://pydantic-docs.helpmanual.io/usage/postponed_annotations/
MappingSet.update_forward_refs()
Mapping.update_forward_refs()
LiteralMapping.update_forward_refs()
MappingRegistry.update_forward_refs()
MappingSetReference.update_forward_refs()
Prefix.update_forward_refs()

