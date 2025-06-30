export interface LabMetadata {
  id: string;
  title: string;
  description: string;
  category: 'beginners' | 'intermediate' | 'advanced' | 'networking' | 'security' | 'cloud' | 'kubernetes';
  subcategory?: string;
  difficulty: 1 | 2 | 3 | 4 | 5;
  duration: string; // e.g., "15 minutes", "1 hour"
  prerequisites?: string[];
  tags: string[];
  author?: string;
  lastUpdated: string;
  featured?: boolean;
}

export interface LabSection {
  id: string;
  title: string;
  content: string;
  type: 'text' | 'code' | 'command' | 'warning' | 'info' | 'image';
  language?: string; // for code blocks
  imageUrl?: string; // for image sections
}

export interface Lab extends LabMetadata {
  sections: LabSection[];
  nextLab?: string;
  previousLab?: string;
}

export interface LabCategory {
  name: string;
  description: string;
  icon: string;
  labs: LabMetadata[];
  subcategories?: {
    name: string;
    labs: LabMetadata[];
  }[];
}
