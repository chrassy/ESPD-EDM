<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="urn:X-test:UBL:Pre-award:QualificationApplicationResponse"
	xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
	xmlns:cev="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonAggregateComponents-1"
	xmlns:espd-cac="urn:grow:names:specification:ubl:schema:xsd:ESPD-CommonAggregateComponents-1"
	xmlns:cbc-old="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
	xmlns:espd-old="urn:grow:names:specification:ubl:schema:xsd:ESPDResponse-1"
	xmlns:espd="urn:com:grow:espd:2.0.2"
	xmlns:cev-cbc="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonBasicComponents-1"
	xmlns:espd-cbc="urn:grow:names:specification:ubl:schema:xsd:ESPD-CommonBasicComponents-1"
	xmlns:cac-old="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
	xmlns:cac="urn:X-test:UBL:Pre-award:CommonAggregate"
	xmlns:espd-req="urn:grow:names:specification:ubl:schema:xsd:ESPDRequest-1"
	xmlns:ccv="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonAggregateComponents-1"
	xmlns:ccv-cbc="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonBasicComponents-1"
	xmlns:util="java:java.util.UUID" xmlns:cbc="urn:X-test:UBL:Pre-award:CommonBasic"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	exclude-result-prefixes="cev-cbc ccv-cbc cbc-old cev ccv cac-old ext espd-req espd-cac espd-old">
	<xsl:import href="./inc/common/RootElements.xslt"/>
	<xsl:import href="./inc/common/ContractingAuthorityData.xslt"/>
	<xsl:import href="./inc/common/ProcurementProjectLot.xslt"/>
	<xsl:import href="./inc/common/AdditionalDocumentReference.xslt"/>
	<xsl:import href="./inc/common/AvailableOnline.xslt"/>
	<xsl:import href="./inc/common/Signature.xslt"/>
	<xsl:import href="./inc/common/EconomicOperatorParty.xslt"/>
	<xsl:import href="./inc/criteria/EO_DATA.SHELTERED_WORKSHOP.xslt"/>
	<xsl:import href="./inc/criteria/EO_DATA.SUBCONTRACTS.xslt"/>
	<xsl:import href="./inc/criteria/CRITERION.OTHER.EO_DATA.RELIES_ON_OTHER_CAPACITIES.xslt"/>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

	<!-- Include the core elements of the each file (RootElements etc) -->
	<xsl:template name="TenderingCriterionPropertyEmptyCaption">
		<cac:TenderingCriterionProperty>
			<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">
				<xsl:value-of select="util:toString(util:randomUUID())"/>
			</cbc:ID>
			<cbc:Description>[Additional information; e.g. no evidences online]</cbc:Description>
			<cbc:TypeCode listID="CriterionElementType" listAgencyID="EU-COM-GROW"
				listVersionID="2.0.2">CAPTION</cbc:TypeCode>
			<cbc:ValueDataTypeCode listID="ResponseDataType" listAgencyID="EU-COM-GROW"
				listVersionID="2.0.2">NONE</cbc:ValueDataTypeCode>
		</cac:TenderingCriterionProperty>
	</xsl:template>
	<xsl:template name="answersByContractors">
		<xsl:for-each select="//ccv:Response">
			<xsl:choose>
				<xsl:when
					test="cbc-old:Date/preceding::ccv:Requirement[1]/ccv:Response/cbc-old:Date"> </xsl:when>

				<xsl:when test="ccv-cbc:Code"> </xsl:when>
				<xsl:when
					test="cbc-old:Description/preceding::ccv:Requirement[1]/ccv:Response/ccv-cbc:Code"> </xsl:when>
				<xsl:when
					test="ancestor::ccv:Criterion[cbc-old:ID = '9c70375e-1264-407e-8b50-b9736bc08901']"/>
				<xsl:otherwise>
					<xsl:variable name="responseDataType" select="ancestor::*/@responseDataType"/>
					<cac:TenderingCriterionResponse>
						<cbc:ID schemeID="ISO/IEC 9834-8:2008 - 4UUID" schemeAgencyID="EU-COM-GROW"
							schemeVersionID="2.0.2">
							<xsl:value-of select="util:toString(util:randomUUID())"/>
						</cbc:ID>
						<cbc:ValidatedCriterionPropertyID schemeID="CriteriaTaxonomy"
							schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">
							<xsl:value-of select="parent::ccv:Requirement/cbc-old:ID/text()"/>
						</cbc:ValidatedCriterionPropertyID>
						<cbc:ConfidentialityLevelCode listID="ConfidentialityLevel"
							listAgencyID="EU-COM-GROW" listVersionID="2.0.2"
							>PUBLIC</cbc:ConfidentialityLevelCode>
						<xsl:if test="cev:Evidence">
							<cac:EvidenceSupplied>
								<cbc:ID schemeAgencyID="ISO/IEC 9834-8:2008 - 4UUID">
									<xsl:value-of select="../../ccv:Requirement[1]/cbc-old:ID[1]"/>
								</cbc:ID>
							</cac:EvidenceSupplied>
						</xsl:if>
						<xsl:if test="not(cev:Evidence)">
							<xsl:choose>
								<xsl:when test="$responseDataType = 'DATE'">

									<cac:ApplicablePeriod>
										<cbc:StartDate>
											<xsl:copy-of select="cbc-old:Date/text()"/>
										</cbc:StartDate>
										<cbc:EndDate>
											<xsl:copy-of select="following::cbc-old:Date[1]/text()"
											/>
										</cbc:EndDate>
									</cac:ApplicablePeriod>
								</xsl:when>
								<xsl:otherwise>
									<cac:ResponseValue>
										<cbc:ID schemeID="ISO/IEC 9834-8:2008 - 4UUID"
											schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">
											<xsl:value-of select="util:toString(util:randomUUID())"
											/>
										</cbc:ID>
										<xsl:choose>
											<xsl:when test="$responseDataType = 'INDICATOR'">
												<cbc:ResponseIndicator>
												<xsl:copy-of select="ccv-cbc:Indicator/text()"/>
												</cbc:ResponseIndicator>
											</xsl:when>
											<xsl:when test="$responseDataType = 'DESCRIPTION'">

												<cbc:Description>
												<xsl:copy-of select="cbc-old:Description/text()"/>
												</cbc:Description>
											</xsl:when>
											<xsl:when test="$responseDataType = 'AMOUNT'">
												<cbc:ResponseAmount>
												<xsl:attribute name="currencyID"
												select="node()/@currencyID"/>
												<xsl:copy-of select="cbc-old:Amount/text()"/>
												</cbc:ResponseAmount>
											</xsl:when>
										</xsl:choose>
									</cac:ResponseValue>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
					</cac:TenderingCriterionResponse>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="Evidence">
		<xsl:for-each select="//cev:Evidence">
			<cac:Evidence>
				<cbc:ID schemeAgencyID="EU-COM-GROW">
					<xsl:value-of select="node()/ancestor::ccv:Requirement[1]/cbc-old:ID[1]"/>
				</cbc:ID>
				<cbc:ConfidentialityLevelCode listID="ConfidentialityLevel"
					listAgencyID="EU-COM-GROW" listVersionID="2.0.2"
					>PUBLIC</cbc:ConfidentialityLevelCode>
				<cac:DocumentReference>
					<cbc:ID schemeAgencyID="EU-COM-GROW">
						<xsl:choose>
							<xsl:when
								test="following::node()/ccv:Requirement/ccv:Response/ccv-cbc:Code">
								<xsl:value-of select="following::ccv-cbc:Code[1]"/>
							</xsl:when>
						</xsl:choose>
					</cbc:ID>
					<cac:Attachment>
						<cac:ExternalReference>
							<cbc:URI>
								<xsl:value-of
									select="cev:EvidenceDocumentReference/cac-old:Attachment/cac-old:ExternalReference/cbc-old:URI"
								/>
							</cbc:URI>
						</cac:ExternalReference>
					</cac:Attachment>
					<cac:IssuerParty>
						<cac:PartyName>
							<cbc:Name>
								<xsl:value-of
									select="ancestor::ccv:Requirement/following::ccv:Requirement[2]/ccv:Response/cbc-old:Description"
								/>
							</cbc:Name>
						</cac:PartyName>
					</cac:IssuerParty>
				</cac:DocumentReference>
			</cac:Evidence>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="/">
		<!-- Transform the root node to 2.0.0 Mapping structure  -->
		<QualificationApplicationResponse xmlns:cac="urn:X-test:UBL:Pre-award:CommonAggregate"
			xmlns:cbc="urn:X-test:UBL:Pre-award:CommonBasic"
			xmlns:espd-old="urn:grow:names:specification:ubl:schema:xsd:ESPDResponse-1"
			xmlns:espd="urn:com:grow:espd:2.0.2" xmlns:fn="http://www.w3.org/2005/xpath-functions"
			xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
			xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0"
			xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
			xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
			xmlns:util="java:java.util.UUID" xmlns:xs="http://www.w3.org/2001/XMLSchema"
			xsi:schemaLocation="urn:X-test:UBL:Pre-award:QualificationApplicationResponse ../../../xsdrt/maindoc/UBL-QualificationApplicationResponse-2.2-Pre-award.xsd"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			<!-- Since we add the root elements externally, start to apply templates from ccv:Criterion -->
			<xsl:call-template name="RootElements"/>
			<xsl:call-template name="ContractingAuthorityData"/>
			<xsl:call-template name="EconomicOperatorParty"/>
			<xsl:call-template name="ProcurementProjectLot"/>
			<xsl:apply-templates select="//ccv:Criterion"/>
			<xsl:text disable-output-escaping="yes">&lt;</xsl:text>!-- THIS IS WHERE THE ANSWERS
			START !!!!!!!!!!! --<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
			<xsl:call-template name="answersByContractors"/>
			<!-- AdditionalDocumentReference implementation-->
			<xsl:call-template name="AdditionalDocumentReference"/>
			<xsl:call-template name="Signature"/>
			<xsl:call-template name="Evidence"/>
		</QualificationApplicationResponse>
	</xsl:template>
	<xsl:template match="cac-old:ProcurementProjectLot"> </xsl:template>
	<!-- Match with each elements to apply the mapping changes and create a structure to copy or recreate the values-->
	<xsl:template match="ccv:Criterion/cbc-old:ID">
		<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">
			<!-- Select the values from v1.0.2 and apply them into 2.0.0 -->
			<xsl:apply-templates select="node()"/>
		</cbc:ID>
	</xsl:template>
	<xsl:template match="ccv:Criterion/cbc-old:TypeCode">
		<cbc:CriterionTypeCode listID="CriteriaTypeCode" listAgencyID="EU-COM-GROW"
			listVersionID="2.0.2">
			<xsl:apply-templates select="node()"/>
		</cbc:CriterionTypeCode>
	</xsl:template>
	<!-- Select the values from v1.0.2 and apply them into 2.0.0 -->
	<xsl:template match="ccv:Criterion/cbc-old:Name">
		<cbc:Name>
			<xsl:apply-templates select="node()"/>
		</cbc:Name>
	</xsl:template>
	<!-- Select the values from v1.0.2 and apply them into 2.0.0 -->
	<xsl:template match="ccv:Criterion/cbc-old:Description">
		<cbc:Description>
			<xsl:apply-templates select="node()"/>
		</cbc:Description>
	</xsl:template>
	<!-- Select the values from v1.0.2 and apply them into 2.0.0 -->
	<xsl:template match="ccv:LegislationReference">
		<cac:Legislation>
			<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">
				<xsl:value-of select="util:toString(util:randomUUID())"/>
			</cbc:ID>
			<xsl:apply-templates/>
		</cac:Legislation>
	</xsl:template>
	<xsl:template match="ccv:LegislationReference/ccv-cbc:Title">
		<cbc:Title>
			<xsl:apply-templates select="node()"/>
		</cbc:Title>
	</xsl:template>
	<xsl:template match="ccv:LegislationReference/cbc-old:Description">
		<cbc:Description>
			<xsl:apply-templates select="node()"/>
		</cbc:Description>
	</xsl:template>
	<xsl:template match="ccv:LegislationReference/ccv-cbc:JurisdictionLevelCode">
		<cbc:JurisdictionLevel>
			<xsl:apply-templates select="node()"/>
		</cbc:JurisdictionLevel>
	</xsl:template>
	<xsl:template match="ccv:LegislationReference/ccv-cbc:Article">
		<cbc:Article>
			<xsl:apply-templates select="node()"/>
		</cbc:Article>
	</xsl:template>
	<xsl:template match="ccv:LegislationReference/cbc-old:URI">
		<cbc:URI>
			<xsl:apply-templates select="node()"/>
		</cbc:URI>
		<cac:Language>
			<cbc:LocaleCode listID="LanguageCodeEU" listAgencyName="EU-COM-GROW"
				listVersionID="2.0.2">EN</cbc:LocaleCode>
		</cac:Language>
	</xsl:template>
	<xsl:template match="ccv:Criterion">
		<xsl:choose>
			<xsl:when test="cbc-old:ID = '9c70375e-1264-407e-8b50-b9736bc08901'"> </xsl:when>
			<xsl:when test="cbc-old:TypeCode = 'CRITERION.OTHER.EO_DATA.SHELTERED_WORKSHOP'">
				<xsl:call-template name="EO_DATA.SHELTERED"/>
			</xsl:when>
			<xsl:when test="cbc-old:TypeCode = 'CRITERION.OTHER.EO_DATA.RELIES_ON_OTHER_CAPACITIES'">
				<xsl:call-template name="DATA_RELIES_ON_OTHER_CAPACITIES"/>
			</xsl:when>
			<xsl:when
				test="cbc-old:TypeCode = 'CRITERION.OTHER.EO_DATA.SUBCONTRACTS_WITH_THIRD_PARTIES'">
				<xsl:call-template name="EO_DATA.SUBCONTRACTS"/>
			</xsl:when>
			<xsl:otherwise>
				<cac:TenderingCriterion>
					<xsl:apply-templates/>
				</cac:TenderingCriterion>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="ccv:RequirementGroup">
		<cac:TenderingCriterionPropertyGroup>

			<xsl:apply-templates select="node()"/>


		</cac:TenderingCriterionPropertyGroup>
		<xsl:choose>
			<xsl:when
				test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.EXCLUSION.MISCONDUCT.MC_PROFESSIONAL']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
			<xsl:when
				test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.EXCLUSION.MISCONDUCT.MARKET_DISTORTION']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
			<xsl:when
				test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.EXCLUSION.CONFLICT_OF_INTEREST.MISINTERPRETATION']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
			<xsl:when
				test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.MANAGEMENT.SUBCONTRACTING_PROPORTION']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
			<xsl:when
				test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.EXCLUSION.SOCIAL.ENVIRONMENTAL_LAW']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
			<xsl:when
				test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.EXCLUSION.SOCIAL.SOCIAL_LAW']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
			<xsl:when
				test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.EXCLUSION.SOCIAL.LABOUR_LAW']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
			<xsl:when
				test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.EXCLUSION.CONFLICT_OF_INTEREST.PROCEDURE_PARTICIPATION']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
			<xsl:when
				test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.EXCLUSION.CONFLICT_OF_INTEREST.PROCEDURE_PREPARATION']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
			<xsl:when
				test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.EXCLUSION.CONFLICT_OF_INTEREST.EARLY_TERMINATION']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
			<xsl:when
				test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.SUPPLY_CHAIN_MANAGEMENT']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
			<xsl:when
				test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.CHECKS.ALLOWANCE_OF_CHECKS']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
			<xsl:when
				test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.OTHER.EO_DATA.RELIES_ON_OTHER_CAPACITIES']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
			<xsl:when
				test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.OTHER.EO_DATA.REGISTERED_IN_OFFICIAL_LIST']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
			<xsl:when
				test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.OTHER.EO_DATA.TOGETHER_WITH_OTHERS']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
			<xsl:when
				test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.TURNOVER.SET_UP']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- SubsidiaryTenderingCriterionGroup implementation -->
	<xsl:template match="ccv:RequirementGroup[@pi]/ccv:RequirementGroup">
		<cac:SubsidiaryTenderingCriterionPropertyGroup>
			<xsl:apply-templates select="node()"/>
		</cac:SubsidiaryTenderingCriterionPropertyGroup>
	</xsl:template>
	<xsl:template match="ccv:RequirementGroup[@pi]/ccv:RequirementGroup/cbc-old:ID">
		<cbc:ID>
			<xsl:apply-templates select="node()"/>
		</cbc:ID>
	</xsl:template>
	<xsl:template match="ccv:RequirementGroup/cbc-old:ID">
		<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">
			<xsl:apply-templates select="node()"/>
		</cbc:ID>
		<xsl:choose>
			<xsl:when test="parent::ccv:RequirementGroup[@pi = 'GROUP_FULFILLED.ON_TRUE']">
				<cbc:PropertyGroupTypeCode listID="PropertyGroupType" listAgencyID="EU-COM-GROW"
					listVersionID="2.0.2">ONTRUE</cbc:PropertyGroupTypeCode>
			</xsl:when>
			<xsl:when test="parent::ccv:RequirementGroup[@pi = 'GROUP_FULFILLED.ON_FALSE']">
				<cbc:PropertyGroupTypeCode listID="PropertyGroupType" listAgencyID="EU-COM-GROW"
					listVersionID="2.0.2">ONFALSE</cbc:PropertyGroupTypeCode>
			</xsl:when>
			<xsl:otherwise>
				<cbc:PropertyGroupTypeCode listID="PropertyGroupType" listAgencyID="EU-COM-GROW"
					listVersionID="2.0.2">ON*</cbc:PropertyGroupTypeCode>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="not(following-sibling::ccv:Requirement)">
			<xsl:call-template name="TenderingCriterionPropertyEmptyCaption"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="ccv:Requirement">

		<xsl:choose>
			<xsl:when test="self::node()[@responseDataType = 'CODE']"> </xsl:when>
			<xsl:when test="preceding::ccv:Requirement[1][@responseDataType = 'CODE']"> </xsl:when>
			<xsl:when
				test="parent::ccv:RequirementGroup[cbc-old:ID = 'c0cd9c1c-e90a-4ff9-bce3-ac0fe31abf16']">
				<xsl:if test="count(following-sibling::*) = 2">
					<cac:TenderingCriterionProperty>
						<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW"
							schemeVersionID="2.0.2">
							<xsl:value-of
								select="cbc-old:Description/ancestor::ccv:RequirementGroup[cbc-old:ID = 'c0cd9c1c-e90a-4ff9-bce3-ac0fe31abf16']/ccv:Requirement[1]/cbc-old:ID"
							/>
						</cbc:ID>
						<cbc:Description>
							<xsl:value-of
								select="
									string-join((cbc-old:Description/ancestor::ccv:RequirementGroup[cbc-old:ID = 'c0cd9c1c-e90a-4ff9-bce3-ac0fe31abf16']/ccv:Requirement[1]/cbc-old:Description[1],
									cbc-old:Description/ancestor::ccv:RequirementGroup[cbc-old:ID = 'c0cd9c1c-e90a-4ff9-bce3-ac0fe31abf16']/ccv:Requirement[2]/cbc-old:Description[1]), ';')"
							/>
						</cbc:Description>
						<cbc:TypeCode listID="CriterionElementType" listAgencyID="EU-COM-GROW"
							listVersionID="2.0.2">QUESTION</cbc:TypeCode>
						<cbc:ValueDataTypeCode listID="ResponseDataType" listAgencyID="EU-COM-GROW"
							listVersionID="2.0.2">PERIOD</cbc:ValueDataTypeCode>
					</cac:TenderingCriterionProperty>
					<cac:TenderingCriterionProperty>
						<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW"
							schemeVersionID="2.0.2">
							<xsl:value-of
								select="cbc-old:Description/ancestor::ccv:RequirementGroup[cbc-old:ID = 'c0cd9c1c-e90a-4ff9-bce3-ac0fe31abf16']/ccv:Requirement[3]/cbc-old:ID"/>

						</cbc:ID>
						<cbc:Description>
							<xsl:value-of
								select="cbc-old:Description/ancestor::ccv:RequirementGroup[cbc-old:ID = 'c0cd9c1c-e90a-4ff9-bce3-ac0fe31abf16']/ccv:Requirement[3]/cbc-old:Description[1]"
							/>
						</cbc:Description>
						<cbc:TypeCode listID="CriterionElementType" listAgencyID="EU-COM-GROW"
							listVersionID="2.0.2">QUESTION</cbc:TypeCode>
						<cbc:ValueDataTypeCode listID="ResponseDataType" listAgencyID="EU-COM-GROW"
							listVersionID="2.0.2">AMOUNT</cbc:ValueDataTypeCode>
					</cac:TenderingCriterionProperty>
				</xsl:if>
			</xsl:when>
			<xsl:when
				test="parent::ccv:RequirementGroup[cbc-old:ID = '96f00020-0a25-402e-b850-2378e83b5695']">
				<xsl:if test="count(following-sibling::*) = 4">
					<cac:TenderingCriterionProperty>
						<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW"
							schemeVersionID="2.0.2">
							<xsl:value-of
								select="cbc-old:Description/ancestor::ccv:RequirementGroup[cbc-old:ID = '96f00020-0a25-402e-b850-2378e83b5695']/ccv:Requirement[1]/cbc-old:ID"
							/>
						</cbc:ID>
						<cbc:Description>
							<xsl:value-of
								select="
									cbc-old:Description/ancestor::ccv:RequirementGroup[cbc-old:ID = '96f00020-0a25-402e-b850-2378e83b5695']/ccv:Requirement[1]/cbc-old:Description[1]"
							/>
						</cbc:Description>
						<cbc:TypeCode listID="CriterionElementType" listAgencyID="EU-COM-GROW"
							listVersionID="2.0.2">QUESTION</cbc:TypeCode>
						<cbc:ValueDataTypeCode listID="ResponseDataType" listAgencyID="EU-COM-GROW"
							listVersionID="2.0.2">DESCRIPTION</cbc:ValueDataTypeCode>
					</cac:TenderingCriterionProperty>
					<cac:TenderingCriterionProperty>
						<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW"
							schemeVersionID="2.0.2">
							<xsl:value-of
								select="cbc-old:Description/ancestor::ccv:RequirementGroup[cbc-old:ID = '96f00020-0a25-402e-b850-2378e83b5695']/ccv:Requirement[2]/cbc-old:ID"/>

						</cbc:ID>
						<cbc:Description>
							<xsl:value-of
								select="cbc-old:Description/ancestor::ccv:RequirementGroup[cbc-old:ID = '96f00020-0a25-402e-b850-2378e83b5695']/ccv:Requirement[2]/cbc-old:Description[1]"
							/>
						</cbc:Description>
						<cbc:TypeCode listID="CriterionElementType" listAgencyID="EU-COM-GROW"
							listVersionID="2.0.2">QUESTION</cbc:TypeCode>
						<cbc:ValueDataTypeCode listID="ResponseDataType" listAgencyID="EU-COM-GROW"
							listVersionID="2.0.2">AMOUNT</cbc:ValueDataTypeCode>
					</cac:TenderingCriterionProperty>
					<cac:TenderingCriterionProperty>
						<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW"
							schemeVersionID="2.0.2">
							<xsl:value-of
								select="cbc-old:Description/ancestor::ccv:RequirementGroup[cbc-old:ID = '96f00020-0a25-402e-b850-2378e83b5695']/ccv:Requirement[3]/cbc-old:ID"/>

						</cbc:ID>
						<cbc:Description>
							<xsl:value-of
								select="
									string-join((cbc-old:Description/ancestor::ccv:RequirementGroup[cbc-old:ID = '96f00020-0a25-402e-b850-2378e83b5695']/ccv:Requirement[3]/cbc-old:Description[1],
									cbc-old:Description/ancestor::ccv:RequirementGroup[cbc-old:ID = '96f00020-0a25-402e-b850-2378e83b5695']/ccv:Requirement[4]/cbc-old:Description[1]), ';')"
							/>
						</cbc:Description>
						<cbc:TypeCode listID="CriterionElementType" listAgencyID="EU-COM-GROW"
							listVersionID="2.0.2">QUESTION</cbc:TypeCode>
						<cbc:ValueDataTypeCode listID="ResponseDataType" listAgencyID="EU-COM-GROW"
							listVersionID="2.0.2">PERIOD</cbc:ValueDataTypeCode>
					</cac:TenderingCriterionProperty>
					<cac:TenderingCriterionProperty>
						<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW"
							schemeVersionID="2.0.2">
							<xsl:value-of
								select="cbc-old:Description/ancestor::ccv:RequirementGroup[cbc-old:ID = '96f00020-0a25-402e-b850-2378e83b5695']/ccv:Requirement[5]/cbc-old:ID"/>

						</cbc:ID>
						<cbc:Description>
							<xsl:value-of
								select="cbc-old:Description/ancestor::ccv:RequirementGroup[cbc-old:ID = '96f00020-0a25-402e-b850-2378e83b5695']/ccv:Requirement[5]/cbc-old:Description[1]"
							/>
						</cbc:Description>
						<cbc:TypeCode listID="CriterionElementType" listAgencyID="EU-COM-GROW"
							listVersionID="2.0.2">QUESTION</cbc:TypeCode>
						<cbc:ValueDataTypeCode listID="ResponseDataType" listAgencyID="EU-COM-GROW"
							listVersionID="2.0.2">DESCRIPTION</cbc:ValueDataTypeCode>
					</cac:TenderingCriterionProperty>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<cac:TenderingCriterionProperty>
					<xsl:apply-templates select="node() except (ccv:Response)"/>
					<cbc:TypeCode listID="CriterionElementType" listAgencyID="EU-COM-GROW"
						listVersionID="2.0.2">QUESTION</cbc:TypeCode>
					<cbc:ValueDataTypeCode listID="ResponseDataType" listAgencyID="EU-COM-GROW"
						listVersionID="2.0.2">
						<xsl:choose>
							<xsl:when test="@responseDataType = 'EVIDENCE_URL'">
								<xsl:value-of select="'EVIDENCE_IDENTIFIER'"/>
							</xsl:when>
							<xsl:when test="@responseDataType = 'PERIOD'">
								<xsl:value-of select="'DESCRIPTION'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="@responseDataType"/>
							</xsl:otherwise>
						</xsl:choose>
					</cbc:ValueDataTypeCode>
				</cac:TenderingCriterionProperty>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="ccv:Requirement/cbc-old:ID">
		<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">
			<xsl:value-of select="node()"/>
		</cbc:ID>
	</xsl:template>
	<xsl:template match="ccv:Requirement/cbc-old:Description">
		<cbc:Description>
			<xsl:choose>
				<xsl:when test="node() = 'URL'">
					<xsl:value-of select="'Evidence supplied'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="node()"/>
				</xsl:otherwise>
			</xsl:choose>
		</cbc:Description>
	</xsl:template>
	<!-- Select the values from v1.0.2 and apply them into 2.0.0 -->
	<xsl:template match="ccv:RequirementGroup[@pi]">


		<cac:SubsidiaryTenderingCriterionPropertyGroup>
			<xsl:apply-templates select="node()"/>
		</cac:SubsidiaryTenderingCriterionPropertyGroup>

	</xsl:template>
	<!-- Select the values from v1.0.2 and apply them into 2.0.0 -->
	<xsl:template match="ccv:RequirementGroup[@pi]/cbc-old:ID">
		<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">
			<xsl:value-of select="node()"/>
		</cbc:ID>
		<xsl:choose>
			<xsl:when test="parent::ccv:RequirementGroup[@pi = 'GROUP_FULFILLED.ON_TRUE']">
				<cbc:PropertyGroupTypeCode listID="PropertyGroupType" listAgencyID="EU-COM-GROW"
					listVersionID="2.0.2">ONTRUE</cbc:PropertyGroupTypeCode>
			</xsl:when>
			<xsl:when test="parent::ccv:RequirementGroup[@pi = 'GROUP_FULFILLED.ON_FALSE']">

				<cbc:PropertyGroupTypeCode listID="PropertyGroupType" listAgencyID="EU-COM-GROW"
					listVersionID="2.0.2">ONFALSE</cbc:PropertyGroupTypeCode>
			</xsl:when>
			<xsl:otherwise>
				<cbc:PropertyGroupTypeCode listID="PropertyGroupType" listAgencyID="EU-COM-GROW"
					listVersionID="2.0.2">ON*</cbc:PropertyGroupTypeCode>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>
