[Version = "1.0.2"]
section POWERAUTOMATERESTAPIDOD;

[DataSource.Kind="POWERAUTOMATERESTAPIDOD", Publish="POWERAUTOMATERESTAPIDOD.Publish"]
shared POWERAUTOMATERESTAPIDOD.FunctionCatalog = () =>
let
    objects = #table(
        {"Name","Key","Data","ItemKind","ItemName","IsLeaf"},
        {
            {"GetEnvironments","GetEnvironments",POWERAUTOMATERESTAPIDOD.GetEnvironments,"Function","GetEnvironments",true},
            {"GetPersonalFlows","GetPersonalFlows",POWERAUTOMATERESTAPIDOD.GetPersonalFlows,"Function","GetPersonalFlows",true},
            {"GetTeamFlows","GetTeamFlows",POWERAUTOMATERESTAPIDOD.GetTeamFlows,"Function","GetTeamFlows",true},
            {"GetFlow","GetFlow",POWERAUTOMATERESTAPIDOD.GetFlow,"Function","GetFlow",true},
            {"GetFlowRuns","GetFlowRuns",POWERAUTOMATERESTAPIDOD.GetFlowRuns,"Function","GetFlowRuns",true}
        }),
    navTable = Table.ForceToNavigationTable(objects,{"Key"},"Name","Data","ItemKind","ItemName","IsLeaf")
in
    navTable;

/* GLOBAL VARIABLES */
API_VERSION = "2016-11-01";

/*****************
GetEnvironments

URL: {API EndPoint}/providers/Microsoft.ProcessSimple/environments

Inputs:
none
*****************/
POWERAUTOMATERESTAPIDOD.GetEnvironments = Value.ReplaceType(
    GetEnvironments,
    GetEnvironmentsType
);

GetEnvironmentsType = type function () 
    as table meta [
        Documentation. Name = "POWERAUTOMATERESTAPIDOD.GetEnvironments",
        Documentation. LongDescription = "Returns the environments available to the requestor.",
        Documentation. Examples = { 
            [
                Code= "=POWERAUTOMATERESTAPIDOD.GetEnvironments(""xxx-xxxx-yyxa ... "")",
                Result = "API call to Power Automate to return the environment available to the requestor, returned as JSON"
            ]
        }
    ];

GetEnvironments = () => 
    let
        result = GetJSON("/providers/Microsoft.ProcessSimple/environments") 
    in
        result;

/*****************
GetPersonalFlows

URL: {API EndPoint}/providers/Microsoft.ProcessSimple/environments/{EvironmentId}/flows?$filter=search(%27personal%27)&$top=50&include=includeSolutionCloudFlows&api-version=2016-11-01

Inputs:
    EnvironmentId
*****************/
shared POWERAUTOMATERESTAPIDOD.GetPersonalFlows = Value.ReplaceType(
    GetPersonalFlows,
    GetPersonalFlowsType
);

GetPersonalFlowsType = type function ( 
    optional EnvId as ( 
        type text meta [
            Documentation.FieldCaption = "Environment ID",
            Documentation.FieldDescription = "The Environment ID for the Flow",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa ... "
            }
        ]
    ),
    optional Parameters as (
        type text meta [
            Documentation.FieldCaption = "URL Arguments",
            Documentation.FieldDescription = "Text arguments for the URL, when left blank all flows are targeted.", 
            Documentation.SampleValues = {
                "$filter=search(%27personal%27)&$top=50&include=includeSolutionCloudFlows"
            }
        ]
    )
) as table meta [
    Documentation.Name = "POWERAUTOMATERESTAPIDOD.GetPersonalFlows",
    Documentation.LongDescription = "Returns the Personal flows (shown as Cloud Flows in the Power Automate interface) for a specific environment.", 
    Documentation.Examples = {
        [
            Code = "=POWERAUTOMATERESTAPIDOD.GetPersonalFlows(""xxx-xxxx-yyxa ... "")",
            Result = "API Call to Power Automate returns a JSON representation of all the Personal flows."
        ]
    }
];

GetPersonalFlows = (optional EnvId as text, optional Parameters as text) =>
    let 
        result = 
                if(Parameters <> null)
                then                
                    GetJSON("/providers/Microsoft.ProcessSimple/environments/" & EnvId & "/flows?$filter=search(%27personal%27)&" & Parameters & "&api-version=" & API_VERSION)
                else
                    GetJSON("/providers/Microsoft.ProcessSimple/environments/" & EnvId & "/flows?$filter=search(%27personal%27)$top=50&include=includeSolutionCloudFlows&api-version=" & API_VERSION)
    in
        result;    

/*****************
GetTeamFlows

URL: {API EndPoint}/providers/Microsoft.ProcessSimple/environments/{EvironmentId}/flows?$filter=search(%27team%27)&$top=50&include=includeSolutionCloudFlows&api-version=2016-11-01

Inputs:
    EnvironmentId
*****************/
shared POWERAUTOMATERESTAPIDOD.GetTeamFlows = Value.ReplaceType(
    GetTeamFlows,
    GetTeamFlowsType
);

GetTeamFlowsType = type function ( 
    optional EnvId as ( 
        type text meta [
            Documentation.FieldCaption = "Environment ID",
            Documentation.FieldDescription = "The Environment ID for the Flow",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa ... "
            }
        ]
    ),
    optional Parameters as (
        type text meta [
            Documentation.FieldCaption = "URL Arguments",
            Documentation.FieldDescription = "Text arguments for the URL, when left blank all flows are targeted.", 
            Documentation.SampleValues = {
                "$filter=search(%27team%27)&$top=50&include=includeSolutionCloudFlows"
            }
        ]
    )
) as table meta [
    Documentation.Name = "POWERAUTOMATERESTAPIDOD.GetTeamFlows",
    Documentation.LongDescription = "Returns the Team flows (shown as Shared With Me in the Power Automate interface) for a specific environment.", 
    Documentation.Examples = {
        [
            Code = "=POWERAUTOMATERESTAPIDOD.GetTeamFlows(""xxx-xxxx-yyxa ... "")",
            Result = "API Call to Power Automate returns a JSON representation of all the Team flows."
        ]
    }
];

GetTeamFlows = (optional EnvId as text, optional Parameters as text) =>
    let 
        result = 
                if(Parameters <> null)
                then                
                    GetJSON("/providers/Microsoft.ProcessSimple/environments/" & EnvId & "/flows?$filter=search(%27team%27)&" & Parameters & "&api-version=" & API_VERSION)
                else
                    GetJSON("/providers/Microsoft.ProcessSimple/environments/" & EnvId & "/flows?$filter=search(%27team%27)$top=50&include=includeSolutionCloudFlows&api-version=" & API_VERSION)
    in
        result; 

/***************** 
GetFlow

URL: {API ENDPOINT}/providers/Microsoft.ProcessSimple/environments/{EnvironmentId}/flows/{FlowId}?api-version=2016-11-01

Input:
    EnvironmentId
    FlowId
*****************/
shared POWERAUTOMATERESTAPIDOD.GetFlow = Value.ReplaceType(
    GetFlow,
    GetFlowType
);

GetFlowType = type function ( 
    optional EnvId as ( 
        type text meta [
            Documentation. FieldCaption = "Environment ID",
            Documentation. FieldDescription = "The Environment ID for the Flow", 
            Documentation. SampleValues = { "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional FlowId as ( 
        type text meta [
            Documentation.FieldCaption = "Flow ID",
            Documentation.FieldDescription = "The Flow's ID",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa ... "
            }
        ]
    )
) as table meta [
    Documentation.Name = "POWERAUTOMATERESTAPIDOD.GetFlow",
    Documentation. LongDescription = "Returns the flow's specific details including triggers, steps, and connections.",
    Documentation.Examples = { 
        [
            Code = "=POWERAUTOMATERESTAPIDOD.GetFlow(""xxx-xxxx-yyxa ... "")",
            Result = "API call to Power Automate which returns a JSON result for the flow specified by Flow ID and Environment ID."
        ]
    }
];

GetFlow = (optional EnvId as text, optional FlowId as text) => 
    let
        result = GetJSON("/providers/Microsoft.ProcessSimple/environments/" & EnvId & "/flows/" & FlowId & "?api-version=" & API_VERSION & "&$expand=swagger,properties.connectionreferences.apidefinition,properties.definitionSummary.operations.apiOperation,operationDefinition,plan,properties.throttleData,properties.estimatedsuspensiondata")
    in
        result;  

/***************** 
GetFlowRuns

URL: {API ENDPOINT}/providers/Microsoft.ProcessSimple/environments/{EnvironmentId}/flows/{FlowId}/runs?api-version=2016-11-01

Input:
    EnvironmentId
    FlowId
*****************/
shared POWERAUTOMATERESTAPIDOD.GetFlowRuns = Value.ReplaceType(
    GetFlowRuns,
    GetFlowRunsType
);

GetFlowRunsType = type function ( 
    optional EnvId as ( 
        type text meta [
            Documentation. FieldCaption = "Environment ID",
            Documentation. FieldDescription = "The Environment ID for the Flow", 
            Documentation. SampleValues = { "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional FlowId as ( 
        type text meta [
            Documentation.FieldCaption = "Flow ID",
            Documentation.FieldDescription = "The Flow's ID",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa ... "
            }
        ]
    ),
    optional SkipToken as ( 
        type text meta [
            Documentation.FieldCaption = "Skip Token",
            Documentation.FieldDescription = "Used to get next set of flows run.",
            Documentation.SampleValues = {
                "eyqdfakwek... "
            }
        ]
    )    
) as table meta [
    Documentation.Name = "POWERAUTOMATERESTAPIDOD.GetFlowRuns",
    Documentation. LongDescription = "Returns the flow runs for a specific Flow ID.",
    Documentation.Examples = { 
        [
            Code = "=POWERAUTOMATERESTAPIDOD.GetFlowRuns(""xxx-xxxx-yyxa ... "")",
            Result = "API call to Power Automate which returns a JSON result for the flow specified by Flow ID and Environment ID."
        ]
    }
];

GetFlowRuns = (optional EnvId as text, optional FlowId as text, optional SkipToken as text) => 
    let
        // Check to see if SkipToken is required
        baseURL = "/providers/Microsoft.ProcessSimple/environments/" & EnvId & "/flows/" & FlowId & "/runs?api-version=" & API_VERSION,
        flowRunsURL = if SkipToken = null or Text.Length(Text.Trim(Text.Clean(SkipToken))) = 0 then baseURL else baseURL & "&$skiptoken=" & SkipToken,
        result = GetJSON(flowRunsURL)
    in
        result;        

/*****************
    HELPER FUNCTIONS
*****************/

// Get JSON from API Call
GetJSON = (optional relPath as text) =>
    let
        params = [Headers = [#"Content-Type" = "application/json"], RelativePath = relPath],
        //Get Pages
        //Hard-coded Base URL because Power BI Service won't recognize parameter despite numerous attempts
        webSource = Web.Contents(
            "https://api.flow.appsplatform.us",
            params
        ),
        //Convert to Json
        result = Text.FromBinary(webSource)
    in
        result;

// Get Flows data based on environment id and the odata parameters
GetFlows = (optional EnvId as text, optional Parameters as text) =>
    let 
        result = GetJSON("/providers/Microsoft.ProcessSimple/environments/" & EnvId & "/flows?" & Parameters & "&api-version=2016-11-01")
    in
        result;        

// Data Source Kind description
POWERAUTOMATERESTAPIDOD = [
    TestConnection = (dataSourcePath) => { "POWERAUTOMATERESTAPIDOD.FunctionCatalog"},
    Authentication = [
        Aad = [
            AuthorizationUri = "https://login.microsoftonline.us/common/oauth2/authorize",
            Resource = "https://service.flow.appsplatform.us"
        ]
    ]
];

// Data Source UI publishing description
POWERAUTOMATERESTAPIDOD.Publish = [
    Beta = true,
    Category = "Other",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    LearnMoreUrl = "https://github.com/kerski/powerquery-connector-power-automate-rest-api-usgovdod#readme",
    SourceImage = POWERAUTOMATERESTAPIDOD.Icons,
    SourceTypeImage = POWERAUTOMATERESTAPIDOD.Icons
];

POWERAUTOMATERESTAPIDOD.Icons = [
    Icon16 = { Extension.Contents("POWERAUTOMATERESTAPIDOD16.png"), Extension.Contents("POWERAUTOMATERESTAPIDOD20.png"), Extension.Contents("POWERAUTOMATERESTAPIDOD24.png"), Extension.Contents("POWERAUTOMATERESTAPIDOD32.png") },
    Icon32 = { Extension.Contents("POWERAUTOMATERESTAPIDOD32.png"), Extension.Contents("POWERAUTOMATERESTAPIDOD40.png"), Extension.Contents("POWERAUTOMATERESTAPIDOD48.png"), Extension.Contents("POWERAUTOMATERESTAPIDOD64.png") }
];

//To Navigation Table
Table.ToNavigationTable = (
    table as table,
    keyColumns as list,
    nameColumn as text,
    dataColumn as text,
    itemKindColumn as text,
    itemNameColumn as text,
    isLeafColumn as text
) as table =>
    let
        tableType = Value.Type(
            table
        ),
        newTableType = Type.AddTableKey(
            tableType,
            keyColumns,
            true
        ) meta [
            NavigationTable.NameColumn = nameColumn,
            NavigationTable.DataColumn = dataColumn,
            NavigationTable.ItemKindColumn = itemKindColumn,
            Preview.DelayColumn = itemNameColumn,
            NavigationTable.IsLeafColumn = isLeafColumn
        ],
        navigationTable = Value.ReplaceType(
            table,
            newTableType
        )
    in
        navigationTable;

// Force Navigation Table
Table.ForceToNavigationTable = (
    table as table,
    keyColumns as list,
    nameColumn as text,
    dataColumn as text,
    itemKindColumn as text,
    itemNameColumn as text,
    isLeafColumn as text
) as table =>
    let
        tableType = Value.Type(
            table
        ),
        newTableType = Type.AddTableKey(
            tableType,
            keyColumns,
            true
        ) meta [
            NavigationTable.NameColumn = nameColumn,
            NavigationTable.DataColumn = dataColumn,
            NavigationTable.ItemKindColumn = itemKindColumn,
            NavigationTable.IsLeafColumn = isLeafColumn
        ],
        navigationTable = Value.ReplaceType(
            table,
            newTableType
        )
    in
        navigationTable;