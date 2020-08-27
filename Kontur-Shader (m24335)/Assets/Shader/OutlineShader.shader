Shader "Unlit/OutlineShader"
{
    Properties  // Variables of shader
    {
        _MainTex ("Texture", 2D) = "white" {}                   // Main texture
        _Color("Main Color", Color) = (0.5,0.5,0.5,1)           // Main color
        _OutlineColor("Outline color", Color) = (0,0,0,1)       // Main outline color
        _OutlineWidth("Outline width", Range(1.0,1.1)) = 1.01   // Main outline width
    }

    SubShader 
    {
        Pass // Renders Outline
        {
            Tags { "Queue" = "Transparent" }    // Render Queue

            ZWrite Off  // Allows for render pass below to be drawn on top of this pass

            CGPROGRAM
            
            #pragma vertex vert     // Define for the building function
            #pragma fragment frag   // Define for coloring function

            #include "UnityCG.cginc"    // Built in shader functions

            struct appdata  // How the vertex function receives info
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f  // How the fragment function receives info
            {
                float4 pos : SV_POSITION;
                float3 normal : NORMAL;
            };

            float _OutlineWidth;    // Declaring for v2f Shader
            float4 _OutlineColor;   // –//–

            v2f vert(appdata v)      
            {
                v.vertex.xyz *= _OutlineWidth;  // Width of the Outline

                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex); // Transform object coordinates into the homogeneous coordinates of the camera
                return o;

            }

            half4 frag(v2f i) : COLOR   // Renders proper outline color 
            {
                return _OutlineColor;
            }

            ENDCG
        }

        Pass // Renders Object 
        {
            ZWrite On // Draws Object on top of first pass
            
            Material // Coloring Object
            {
                Diffuse[_Color]
                Ambient[_Color]
            }

            Lighting On // Lighting Object

            SetTexture[_MainTex]
            {
                ConstantColor[_Color]   // Defines constant color that is used in combine command
            }

            SetTexture[_MainTex]
            {
                Combine previous * primary DOUBLE   // Combine previous with primary to increase lighting intensity
            }
        }   
    }
    FallBack "Diffuse"  // Shows shadows
}